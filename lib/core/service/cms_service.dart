import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:intl/intl.dart';

class CmsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'website_cms';

  Stream<List<CmsModel>> getSectionData(String sectionName) {
    return _firestore.collection(collectionName).where('section', isEqualTo: sectionName).snapshots().map((snapshot) =>snapshot.docs.map((doc) => CmsModel.fromFirestore(doc)).toList());
  }

  Future<List<Map<String, dynamic>>> fetchOpenJobs() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('open_jobs').get();

      List<Map<String, dynamic>> list = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      // Sort locally: Oldest jobs on top, newest at the bottom
      list.sort((a, b) {
        Timestamp? timeA = a['createdAt'] as Timestamp?;
        Timestamp? timeB = b['createdAt'] as Timestamp?;
        if (timeA == null || timeB == null) return 0;
        return timeA.compareTo(timeB);
      });

      return list;
    } catch (e) {
      throw Exception('Failed to fetch open jobs: $e');
    }
  }

  
  // ================= 2. CANDIDATE: APPLIED JOBS =================

  // Apply for a Job (Stores into applied_jobs)
  Future<void> applyForJob({
    required String jobId,
    required String jobTitle,
    required String fullName,
    required String whatsappNumber,
    required String email,
    required String message,
    String? linkedinUrl,
  }) async {
    try {
      String appliedDate = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());

      await _firestore.collection('applied_jobs').add({
        'jobId': jobId,
        'jobTitle': jobTitle,
        'fullName': fullName,
        'whatsappNumber': whatsappNumber,
        'email': email,
        'message': message,
        'linkedin': linkedinUrl ?? '',
        'appliedDate': appliedDate,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to apply for job: $e');
    }
  }
  
  Future<void> submitGeneralInquiry({
    required String name,
    required String phone,
    required String email,
    required String message,
  }) async {
    try {
      String submittedDate = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());

      await _firestore.collection('contact_inquiries').add({
        'name': name,
        'phone': phone,
        'email': email,
        'message': message,
        'submittedDate': submittedDate,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to submit inquiry: $e');
    }
  }

}