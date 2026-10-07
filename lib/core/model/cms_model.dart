import 'package:cloud_firestore/cloud_firestore.dart';

class CmsModel {
  final String? id;
  final String section;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String contentType;
  final Timestamp? createdAt;

  CmsModel({
    this.id,
    required this.section,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    this.contentType = 'item',
    this.createdAt,
  });

  // Convert Firestore Document to Model
  factory CmsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CmsModel(
      id: doc.id,
      section: data['section'] ?? '',
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      contentType: data['contentType'] ?? 'item',
      createdAt: data['createdAt'],
    );
  }

  // Convert Model to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'section': section,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageUrl': imageUrl,
      'contentType': contentType,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
