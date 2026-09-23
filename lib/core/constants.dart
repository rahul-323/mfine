import 'package:flutter/material.dart';

class AppConstants {
  static const teal = Color(0xFF00A6BC);
  static const tealDark = Color(0xFF008EA0);
  static const primary = Color(0xFF00BFA5);
  static const coral = Color(0xFFFF674F);
  static const lightBlue = Color(0xFFEAF8FC);
  static const softBackground = Color(0xFFF5FAFB);
  static const text = Color(0xFF171B20);
  static const muted = Color(0xFF6B737B);
  static const cardRadius = 18.0;
  static const pagePadding = 20.0;
}

class SpecialtyData {
  final String title;
  final String asset;
  const SpecialtyData(this.title, this.asset);

  static const items = <SpecialtyData>[
    SpecialtyData('Pediatrician', 'assets/images/specialty_pediatrician.jpg'),
    SpecialtyData('Physician', 'assets/images/specialty_physician.jpg'),
    SpecialtyData('Gynaecologist', 'assets/images/specialty_gynaecologist.jpg'),
    SpecialtyData('Dermatologist', 'assets/images/specialty_dermatologist.jpg'),
    SpecialtyData('Dietitian', 'assets/images/specialty_dietitian.jpg'),
    SpecialtyData('Orthopedician', 'assets/images/specialty_orthopedician.jpg'),
    SpecialtyData(
        'Fertility Specialist', 'assets/images/specialty_fertility.jpg'),
    SpecialtyData('Cardiologist', 'assets/images/specialty_cardiologist.jpg'),
    SpecialtyData(
        'General Surgeon', 'assets/images/specialty_general_surgeon.jpg'),
    SpecialtyData(
        'Gastroenterologist', 'assets/images/specialty_gastroenterologist.jpg'),
    SpecialtyData('Pulmonologist', 'assets/images/specialty_pulmonologist.jpg'),
    SpecialtyData('Oncologist', 'assets/images/specialty_oncologist.jpg'),
    SpecialtyData('Neurosurgeon', 'assets/images/specialty_neurosurgeon.jpg'),
    SpecialtyData('Urologist', 'assets/images/specialty_urologist.jpg'),
    SpecialtyData('Nephrologist', 'assets/images/specialty_nephrologist.jpg'),
  ];
}

class DoctorData {
  final String name;
  final String specialty;
  final String qualification;
  final String languages;
  final String hospital;
  final String city;
  final int experience;
  final double rating;
  final int fee;
  final String asset;

  const DoctorData({
    required this.name,
    required this.specialty,
    required this.qualification,
    required this.languages,
    required this.hospital,
    required this.city,
    required this.experience,
    required this.rating,
    required this.fee,
    required this.asset,
  });

  static const doctors = <DoctorData>[
    DoctorData(
      name: 'Dr. Sanket V Agrawal',
      specialty: 'Pulmonologist',
      qualification: 'MBBS, PGDPM, MD',
      languages: 'English, Hindi',
      hospital: 'mfine Healthcare',
      city: 'Nagpur',
      experience: 9,
      rating: 4.8,
      fee: 799,
      asset: 'assets/images/doctor_sanket.jpg',
    ),
    DoctorData(
      name: 'Dr Punnam Pradeep Kumar',
      specialty: 'Pulmonologist',
      qualification: 'MBBS, MD (Pulmonary Medicine)',
      languages: 'Telugu, English',
      hospital: 'mfine Healthcare',
      city: 'Hyderabad',
      experience: 14,
      rating: 4.7,
      fee: 599,
      asset: 'assets/images/doctor_punnam.jpg',
    ),
    DoctorData(
      name: 'Dr. Prem Prakash Bansal (Pulmonologist)',
      specialty: 'Pulmonologist',
      qualification: 'MBBS, MD (TB & Chest Diseases)',
      languages: 'Hindi, English',
      hospital: 'mfine SELECT',
      city: 'Kota',
      experience: 35,
      rating: 4.9,
      fee: 649,
      asset:
          'https://assets.mfine.co/api/contentservice/attachments/download/Dr151778566795536.jpg/w_229,h_310',
    ),
  ];
}

class NavItemData {
  final String label;
  final IconData icon;
  final String path;
  const NavItemData(this.label, this.icon, this.path);
}
