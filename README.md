# Klock App — Firebase Starter

Proyek praktik Firebase untuk siswa yang sudah terbiasa Flutter dan Riverpod.
**UI sudah selesai.** Kerjakan hanya TODO integrasi Firebase.

1. Baca [brief siswa PDF](docs/BRIEF-SISWA.pdf).
2. Baca [project details PDF] (docs/PROJECT-DETAILS-KLOCK.pdf).
3. Buka folder ini sebagai proyek Flutter terpisah.
4. Jalankan `flutter pub get`.
5. Ikuti [12 TODO Firebase](FIREBASE_TODO.md) berurutan.
6. Jalankan F5 di VS Code atau `flutter run` setelah konfigurasi siap.

## Kondisi awal yang disengaja

- F01 belum diisi: aplikasi menampilkan pemberitahuan Firebase belum terhubung.
- Setelah F01, stream sesi belum berfungsi sampai F03-F04 selesai.
- Sesudah login, riwayat/avatar bisa error sampai F07/F10 selesai.
- Method Firebase yang belum dikerjakan melempar `UnimplementedError`.
- Helper rules dimulai dengan `return false`: tidak ada akses terbuka.
- Tidak ada mode demo, login palsu, konfigurasi Firebase, atau password bawaan.

## Alat dan platform

Flutter dengan Dart sesuai `sdk: ^3.13.2`, Android SDK, VS Code + ekstensi Flutter/Dart,
akun Google, internet, serta perangkat berkamera depan. Android adalah baseline;
iOS opsional dengan Mac/Xcode. Tidak perlu Firebase CLI, FlutterFire CLI, Node.js,
atau npm. Setup dan publikasi rules dilakukan melalui browser Firebase Console.

Android package: `id.sch.klock.klock_app`.
iOS bundle ID: `id.sch.klock.klockApp`.

Setiap peserta mengunduh konfigurasi native proyeknya sendiri. Letakkan JSON Android
di `android/app/google-services.json`. File konfigurasi diabaikan Git agar tidak
menyalin proyek sample/teman. Untuk penilaian dari clean clone, trainer menambahkan
konfigurasi proyek latihan yang sesuai sebelum menjalankan aplikasi.

## File yang dikerjakan

- `lib/main.dart`: F01, inisialisasi Firebase.
- `lib/features/auth/auth_repository.dart`: F03-F05, login/sesi/identitas/logout.
- `firestore.rules`: F06, helper pemilik dan konsistensi batch.
- `lib/features/attendance/data/attendance_repository.dart`: F07-F09, metadata/batch/foto.
- `lib/features/profile/profile_repository.dart`: F10, baca/simpan avatar.
- `firestore.indexes.json`: F11, catatan konfigurasi exemption yang diterapkan di Console.
- `evidence/hasil-uji.md`: F12, hasil pengujian nyata.

F02 dikerjakan di Authentication Console. Provider, model, kamera, kompresi,
penanganan error UI, dan seluruh widget tidak perlu diubah.

## Pemeriksaan

```sh
flutter analyze
flutter test
```

Tes bawaan memeriksa UI/domain/kamera yang sudah disiapkan; **tidak membuktikan**
TODO Firebase sudah lengkap atau rules server sudah benar. Gunakan matriks brief
dan sesi QA bersama trainer untuk menguji backend nyata.

Jangan memakai `allow read, write: if true`, hardcoded login, timestamp HP, atau
menyimpan password untuk membuat UI tampak bekerja. Proyek ini memakai Spark dan
Blob foto maksimal 100 KB, bukan Cloud Storage/Functions.
