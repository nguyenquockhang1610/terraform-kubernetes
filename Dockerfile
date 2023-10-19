# Sử dụng một image gốc có sẵn từ Docker Hub
FROM httpd:2.4

# Sao chép tệp tin và thư mục từ máy tính cục bộ vào image
COPY /web/ /usr/local/apache2/htdocs/

# Khai báo cổng mà Apache sẽ lắng nghe
EXPOSE 80

# Khởi động Apache khi container chạy
CMD ["httpd", "-D", "FOREGROUND"]
