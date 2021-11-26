# Flower Classification
## Quick start
run ```GUI_flower_classification.m```  
Push Show LOOCV result  

## Các mô hình và chức năng chính:  
Lựa chọn 4 mô hình tương ứng ở 2 combobox Feature Method và Model

### HU và Hog với KNN
- Đánh giá bằng phương pháp LOOCV, nhấn nút Show LOOCV result và quan sát Confusion Matrix  
- Với mô hình KNN có thể thay đổi K bằng các điền thông số vào ô K=  
- Test thử các chức năng:  
#### Load Image:   
Tải lên một bức ảnh và phân loại  
#### Load test data:   
Tải lên 1 folder chứa các ảnh dưới định dạng jpg và phân loại, nhấn nút back/next để duyệt hết thư mục  
Cấu trúc tương tự mục Put test data here
#### Load test set: (chưa xong)  
tải lên folder các ảnh đã đánh nhãn sẵn theo cấu trúc tương tự Put test set here  
Chương trình bắt đầu chạy khởi tạo ma trận đặc trưng và đưa vào phân lớp, hiện thị ra kết quả lả Confusion Matrix
  
### Hu và Hog với Neutral Network
- Traning: Các thông số nằm trong mục model/train_*_net.m  
- Đánh giá bằng phương pháp Hold out, Nhấn nút Hold out để xem kết quả  
- Test thử chức năng: Tương tự KNN
