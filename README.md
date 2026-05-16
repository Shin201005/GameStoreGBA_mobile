Nhóm 5:

# Tên đề tài:  Đề tài Xây dựng ứng dụng chơi game cổ điển GBA, GB, GBC

# Giới thiệu app:

Ứng dụng chơi game cổ điển GBA, GB, GBC là ứng dụng di động được phát triển bằng Flutter nhằm xây dựng nền tảng quản lý và chơi game GBA, GB, GBC trực tiếp trên điện thoại.

Ứng dụng cho phép người dùng:
- Đăng nhập tài khoản
- Xem danh sách game
- Xem thông tin chi tiết game
- Chơi game trực tiếp bằng EmulatorJS
- Điều hướng giao diện hiện đại theo phong cách dark mode light mode pink mode

Hệ thống sử dụng WebView Flutter để tích hợp EmulatorJS giúp chạy game trực tiếp bên trong ứng dụng.



# Công nghệ sử dụng:

- Flutter
- Dart
- SharedPreferences
- WebView Flutter
- EmulatorJS
- XAMPP Server



# Chức năng chính

- Đăng ký / Đăng nhập
- Hiển thị danh sách game
- Xem chi tiết game
- Chơi game trực tiếp
- Giao diện dark mode
- Bottom Navigation Bar
- Lưu trạng thái đăng nhập bằng SharedPreferences

# Thành viên:

Hà Vĩnh Phúc - 23810310358 (github Shin201005)

Trần Gia Hồng - 23810310336 (github pink-vip1)

Nguyễn Tấn Dũng - 23810310440 (github dungtan193-cmd)

## Phân công nhiệm vụ cụ thể

### Hà Vĩnh Phúc: 
- Cài đặt WebView Flutter
- Xử lý danh sách game mẫu trong ứng dụng, tạo model dữ liệu game
- Xây dựng giao diện chơi game, chi tiết game, thư viện, yêu thích, admin games, admin tolal game
- Lưu trạng thái khi add favorite , add library, khi thay đổi trạng thái game và user bằng SharedPreferences
- Tích hợp EmulatorJS vào ứng dụng
- Cấu hình đường dẫn ROM game bằng XAMPP Server
- Kiểm thử chức năng Play Game
- Kiểm tra lỗi giao diện và chức năng trên Android Emulator
### Trần Gia Hồng: 
- Tạo model dữ liệu user
- Thiết kế AuthService
- Xử lý chức năng đăng nhập, đăng ký
- Xử lý chia luồng Admin và user
- Xây dựng giao diện đăng nhập, đăng ký, trang tìm kiếm, trang chủ(home), trang store
- Lưu trạng thái đăng nhập bằng SharedPreferences
- Xử lý tìm kiếm và phân loại game
- Điều hướng giữa các màn hình
### Nguyễn Tấn Dũng:
- Thiết kế layout cơ bản cho các Screen
- Thiết kế widgets app button, app text field, game card, loading widget, empty state widget
- Xây dựng giao diện trang splash, onboarding, setting, profile, about, thông báo, admin user, admin stats
- Thiết kế theme service
- Tạo giao diện dark mode light mode pink mode thống nhất cho toàn bộ ứng dụng
- Xây dựng Bottom Navigation Bar

  
# Công nghệ sử dụng

## Flutter
Flutter là framework phát triển ứng dụng đa nền tảng do Google phát triển. Trong đề tài này, Flutter được sử dụng để xây dựng giao diện ứng dụng GameStore Mobile trên Android với khả năng thiết kế UI hiện đại, hiệu năng cao và dễ dàng mở rộng chức năng.

Flutter hỗ trợ cơ chế widget giúp xây dựng giao diện theo dạng component, từ đó dễ dàng tái sử dụng và quản lý source code.



## Dart
Dart là ngôn ngữ lập trình chính được sử dụng trong Flutter. Dart hỗ trợ lập trình hướng đối tượng, cú pháp dễ hiểu và tối ưu cho việc phát triển ứng dụng mobile.

Toàn bộ logic xử lý dữ liệu, điều hướng màn hình và chức năng của ứng dụng được xây dựng bằng Dart.



## SharedPreferences
SharedPreferences là thư viện dùng để lưu dữ liệu cục bộ trên thiết bị Android.

Trong đề tài này, SharedPreferences được sử dụng để:
- Lưu trạng thái đăng nhập
- Lưu dữ liệu người dùng
- Lưu trạng thái game và trạng thái user của Admin
- Duy trì dữ liệu sau khi tắt ứng dụng



## WebView Flutter
WebView Flutter là thư viện cho phép hiển thị nội dung web trực tiếp bên trong ứng dụng Flutter.

Hệ thống sử dụng WebView để:
- Mở EmulatorJS
- Hiển thị giao diện giả lập game
- Chạy game GBA trực tiếp trong ứng dụng



## EmulatorJS
EmulatorJS là trình giả lập game chạy trên nền web bằng JavaScript.

Trong đề tài này, EmulatorJS được sử dụng để giả lập và chơi các game GBA trực tiếp trên điện thoại mà không cần cài thêm ứng dụng giả lập riêng.

EmulatorJS hỗ trợ:
- Điều khiển cảm ứng
- Chạy ROM game GBA
- Tích hợp qua WebView



## XAMPP Server
XAMPP là phần mềm tạo môi trường máy chủ cục bộ.

Trong đề tài, XAMPP được sử dụng để:
- Host file ROM game
- Chạy EmulatorJS local
- Cung cấp đường dẫn truy cập game cho ứng dụng Flutter



## Android Studio
Android Studio là môi trường phát triển chính được sử dụng để lập trình, build và chạy ứng dụng Flutter.

Android Studio hỗ trợ:
- Android Emulator
- Debug ứng dụng
- Quản lý SDK Android
- Theo dõi log và lỗi hệ thống



## Visual Studio Code
Visual Studio Code được sử dụng để viết source code Flutter và quản lý project.

VS Code hỗ trợ:
- Highlight code
- Quản lý extension Flutter/Dart
- Terminal tích hợp
- Git và quản lý source code
- 
# Link video demo
https://drive.google.com/drive/folders/1KuQj3k4Sp_vVtC0-hmJg0qkmL9wbdbly?usp=drive_link

# Hướng dẫn cài đặt

có thể xem video hướng dẫn trong link drive sau khi tải và cài đặt flutter xampp: https://drive.google.com/drive/folders/1KuQj3k4Sp_vVtC0-hmJg0qkmL9wbdbly?usp=drive_link

Bước 1: tải flutter theo hướng dẫn : https://docs.flutter.dev/install/quick

Bước 2: tải xampp theo đường dẫn và cài đặt : https://www.apachefriends.org/download.html

Bước 3: tải emulator máy ảo trong đường dẫn( tải bản 4.2.3.7z nếu có bản mới hơn thì chọn bản mới nhất) : https://github.com/EmulatorJS/EmulatorJS/releases

Bước 4: giải nén đổi tên thư mục thành gba và thay file index trong mã nguồn máy ảo emulator bằng bản trong thư mục index

Bước 5 : cho tất cả các file giải nén của emulator vào thư mục xampp\htdocs của xampp

Bước 6 : clone project về

# Hướng dẫn chạy project

Bước 1 : vào app xampp vừa tải ấn start ở Apache

Bước 2 : cd vào thư mục vừa clone chạy flutter pub get sau đó chạy flutter run

Layout: https://drive.google.com/drive/folders/1YRFHXkY9KH-94cHCa9r4xXDw5IlQ4L97       https://drive.google.com/drive/folders/1gWfRaIT6CLuxTWPecqp8aqWmMWIupp1Q

Ảnh giao diện:

<img width="413" height="948" alt="Screenshot 2026-05-07 091849" src="https://github.com/user-attachments/assets/1088e510-c234-429a-bdd1-88024194a90f" />

<img width="420" height="970" alt="Screenshot 2026-05-07 091903" src="https://github.com/user-attachments/assets/6b18a7e1-5bad-490f-afa4-9712fe52b82d" />

<img width="418" height="946" alt="Screenshot 2026-05-07 091930" src="https://github.com/user-attachments/assets/fae16594-dbe3-47af-877f-9e7dad1bdc70" />

<img width="429" height="949" alt="Screenshot 2026-05-07 091945" src="https://github.com/user-attachments/assets/f3190fec-4e20-4283-bb49-d13bd97c69ea" />

<img width="411" height="919" alt="Screenshot 2026-05-15 001715" src="https://github.com/user-attachments/assets/7f61cbf8-9d50-41ca-ad89-d745e7949d89" />

<img width="414" height="922" alt="Screenshot 2026-05-15 001825" src="https://github.com/user-attachments/assets/2b896bca-16a6-4952-9cb7-722f7b5baee3" />

<img width="417" height="843" alt="Screenshot 2026-05-15 001837" src="https://github.com/user-attachments/assets/68f34206-3668-4051-acff-809b80e76b6f" />

<img width="418" height="920" alt="Screenshot 2026-05-15 001857" src="https://github.com/user-attachments/assets/432b2ff7-4933-415e-abd7-c2b2809d032b" />

<img width="429" height="921" alt="Screenshot 2026-05-15 001915" src="https://github.com/user-attachments/assets/fe14fa95-f435-4a18-b5a9-8a413f629bef" />

<img width="416" height="910" alt="Screenshot 2026-05-15 001928" src="https://github.com/user-attachments/assets/488fb37e-6e6a-4bea-af05-46eaef9c5e3b" />

<img width="415" height="925" alt="Screenshot 2026-05-15 001939" src="https://github.com/user-attachments/assets/5cb3852d-f8c0-44d3-ac14-40b978b00447" />

<img width="405" height="906" alt="Screenshot 2026-05-15 001949" src="https://github.com/user-attachments/assets/b90b7855-88ac-41e4-8bd0-a661bd57b2f7" />

<img width="412" height="924" alt="Screenshot 2026-05-15 002000" src="https://github.com/user-attachments/assets/7bf017e1-bcd9-4df8-9166-9b82e76024ab" />

<img width="417" height="912" alt="Screenshot 2026-05-15 002011" src="https://github.com/user-attachments/assets/e5077fab-f88f-4487-92a7-890d9fad7431" />

<img width="413" height="904" alt="Screenshot 2026-05-15 002023" src="https://github.com/user-attachments/assets/e3779f10-533d-414f-80a2-21c9ee4a610a" />

<img width="415" height="901" alt="Screenshot 2026-05-15 002038" src="https://github.com/user-attachments/assets/16ae6710-0fae-40be-a98c-7cfd15ee2029" />

<img width="410" height="920" alt="Screenshot 2026-05-15 002052" src="https://github.com/user-attachments/assets/a609289f-d8c6-4dda-99ba-6a19def1d3df" />

<img width="414" height="916" alt="Screenshot 2026-05-15 002109" src="https://github.com/user-attachments/assets/1b544071-04fa-4917-8c85-64e8644375a3" />

<img width="404" height="898" alt="Screenshot 2026-05-15 002119" src="https://github.com/user-attachments/assets/6c76d034-b366-4647-b89e-460ee48a4729" />

<img width="417" height="930" alt="Screenshot 2026-05-15 002132" src="https://github.com/user-attachments/assets/c5e7e1cd-c553-4b6e-9f7e-31904c1956cb" />

<img width="412" height="911" alt="Screenshot 2026-05-15 002143" src="https://github.com/user-attachments/assets/7df88689-3a0f-419c-953d-8e5d82d53e7b" />

<img width="387" height="896" alt="Screenshot 2026-05-15 002152" src="https://github.com/user-attachments/assets/e23ddced-a9f7-494e-8ffa-4dea076ae802" />

<img width="403" height="903" alt="Screenshot 2026-05-15 002203" src="https://github.com/user-attachments/assets/035d1024-dd0c-49f0-a1e7-9278263dd049" />

<img width="378" height="829" alt="Screenshot 2026-05-08 185201" src="https://github.com/user-attachments/assets/c93900c5-7c68-4cb0-b876-f2b4317ce1e6" />















