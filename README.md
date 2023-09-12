# GUIDE
1. **Fork** repository
   
3. **Clone** repository
   
   ```sh
   
   git clone https://github.com/Username Github/LABBD23
   
   ```
4. Branch making with **NIM**
   
   ```sh
   
   cd LABBD23
   git branch NIM
   git checkout NIM_ANDA
   
   mkdir NIM_ANDA
   cd NIM_ANDA
   
   ```
   
5. Task submitted by each folder, n(INT) = corresponding chapter
   
   ```sh
   
   mkdir "Pn"
   cd "Pn"
   
   ```
   
6. **commit** task
   
   ```sh
   
   #menambahkan seluruh file sekaligus
   git add .
   
   #memilih file tertentu
   git add "file_name"
   
   git commit -m "Commit message"
   
   ```
   
7. **push** task
    
   ```sh
   
   # pastikan proses commit telah selesai terhadap setiap file
   git push origin NIM_ANDA
   
   ```
   
8. Go to **Pull request** tab and submit by doing pull request
