import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class JobModel {
  final String id;
  final String title;
  final String experience;
  final String location;
  final String salary;
  final String description;
  final String vacancies;

  const JobModel({
    required this.id,
    required this.title,
    required this.experience,
    required this.location,
    required this.salary,
    required this.description,
    required this.vacancies,
  });

  factory JobModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JobModel(
      id: doc.id,
      title: data['title'] ?? '',
      experience: data['experience'] ?? 'Not Specified',
      location: data['location'] ?? 'Lucknow', // Default fallback
      salary: "${data['amount'] ?? ''} (${data['salaryType'] ?? ''})",
      description: data['description'] ?? '',
      vacancies: data['vacancies'] ?? '1',
    );
  }
}

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to fetch open jobs real-time from Firestore 'open_jobs' collection
  Stream<List<JobModel>> getOpenJobsStream() {
    return _firestore.collection('open_jobs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => JobModel.fromFirestore(doc)).toList();
    });
  }

  // Candidate: Apply for a Job (Stores into applied_jobs)
  Future<void> applyForJob({
    required String jobId,
    required String jobTitle,
    required String fullName,
    required String whatsappNumber,
    required String email,
    required String message,
    String? linkedinUrl,
    String? resumeName,
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
        'resumeName': resumeName ?? '',
        'appliedDate': appliedDate,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to apply for job: $e');
    }
  }
}