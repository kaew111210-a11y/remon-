# วิธีนำเว็บการงานงานขึ้นออนไลน์ด้วย Google Firebase

## 1. ติดตั้ง Firebase CLI

ติดตั้ง Node.js ก่อน แล้วเปิด PowerShell รัน:

```powershell
npm install -g firebase-tools
```

## 2. เข้าสู่ระบบ Google

```powershell
firebase login
```

## 3. สร้างโปรเจกต์ Firebase

1. เปิด [Firebase Console](https://console.firebase.google.com/)
2. กด **Create a project**
3. ตั้งชื่อโปรเจกต์ เช่น `kan-ngan-ngan`
4. ไม่จำเป็นต้องเปิด Google Analytics สำหรับเว็บนี้

## 4. เชื่อมโฟลเดอร์เว็บกับโปรเจกต์

เปิด PowerShell ที่โฟลเดอร์นี้:

```powershell
cd "C:\laragon\www\demo\การงานงาน"
firebase use --add
```

เลือกโปรเจกต์ที่สร้างไว้

## 5. เผยแพร่เว็บ

```powershell
firebase deploy
```

เมื่อเสร็จแล้ว Firebase จะแสดงลิงก์ลักษณะนี้:

```text
https://ชื่อโปรเจกต์.web.app
```

ส่งลิงก์นี้ให้คนอื่นเปิดดูเว็บได้เลย

หมายเหตุ: ข้อมูลงานที่สร้างในเว็บจะเก็บแยกในเบราว์เซอร์ของแต่ละคนผ่าน localStorage หากต้องการให้ทุกคนเห็นข้อมูลงานชุดเดียวกัน ให้ตั้งค่า Google Sheets ที่ปุ่ม `⚙ ตั้งค่า` และใช้ Web App URL เดียวกัน
