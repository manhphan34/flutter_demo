import 'package:flutte_demo/src/data/models/Category.dart';
import 'package:flutte_demo/src/data/models/Quiz.dart';
import 'package:flutte_demo/src/data/moor/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: [
                Row(
                  children: [
                    new GestureDetector(
                      onTap: () => SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 8),
                        child: Text("YES"),
                      ),
                    ),
                    new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Padding(
                          padding: EdgeInsets.only(right: 16, bottom: 8),
                          child: Text("NO"),
                        )),
                    SizedBox(height: 12),
                  ],
                )
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Register"),
            centerTitle: true,
          ),
          body: Center(
            child: Text("Register"),
          ),
        ));
  }

  void _createDatabase() {
    var db = AppDatabase().modesDao;
    _insertQuiz(db);
    _insertCategories(db);
  }

  void _insertQuiz(ModesDao db) {
    db.insertQuizzes(quizzes: [
      QuizModel(
        idCat: 1,
        des: "Đâu là quê hương của đàn Guitar?",
        A: "Tây Ban Nha",
        B: "Pháp",
        C: "Anh",
        D: "Việt Nam",
        result: 1,
      ),
      QuizModel(
        idCat: 1,
        des:
            "Ngôn ngữ chú giải thường được sử dụng nhiều nhất trong âm nhạc là của nước nào ?",
        A: "Anh",
        B: "Ý",
        C: "Mỹ",
        D: "Nga",
        result: 2,
      ),
      QuizModel(
        idCat: 1,
        des:
            "Ngôn ngữ được các nhạc sĩ sử dụng nhiều nhất trong thể loại Thanh nhạc (nhạc hát) là ngôn ngữ của nước nào ?",
        A: "Đức",
        B: "Ba Lan",
        C: "Tây Ban Nha",
        D: "Hà Lan",
        result: 1,
      ),
      QuizModel(
        idCat: 1,
        des: "Âm nhạc là gì ?",
        A: "Không biết",
        B: "Chắc là không biết",
        C: "Là một thứ gì đó",
        D: "Khó quá bỏ qua",
        result: 4,
      ),
      QuizModel(
        idCat: 2,
        result: 2,
        D: "Kiên Giang",
        C: " Sóc Trăng",
        B: "Bạc Liêu",
        des: "Bánh Pía là đặc sản của tỉnh nào sau đây ?",
        A: "An Giang",
      ),
      QuizModel(
        idCat: 2,
        result: 1,
        D: "Cá lăng nướng than",
        C: "Lẩu mắm",
        B: "Vịt quay",
        des: " U Minh nổi tiếng với món đặc sản nào sau đây?",
        A: "Cua rang muối",
      ),
      QuizModel(
        idCat: 2,
        result: 4,
        D: "Vũng Tàu",
        C: "Nha Trang",
        B: "Khánh Hòa",
        des: "Bánh khọt là đặc sản của tỉnh ?",
        A: "Bình Thuận",
      ),
      QuizModel(
        idCat: 2,
        result: 3,
        D: "1",
        C: "2",
        B: "3",
        des: "Khi nấu cơm thì nên cho mấy bát muối",
        A: "4",
      ),
      QuizModel(
        idCat: 3,
        des: "Môn nào đươc  gọi là môn thể thao nữ hoàng ?",
        result: 4,
        A: " Cầu lông",
        B: "Bóng bàn",
        C: "Bóng cười",
        D: "Bóng chuyền",
      ),
      QuizModel(
        idCat: 3,
        des: "Bóng đá ra đời ở đâu ?",
        result: 1,
        A: "Việt Nam",
        B: "Trụng Quốc",
        C: "Brazin",
        D: "Anh",
      ),
      QuizModel(
        idCat: 3,
        des: "Câu lạc bộ bóng đá đầu tiên ra đời năm bao nhiểu ?",
        result: 2,
        A: "1823",
        B: "1824",
        C: "1825",
        D: "1826",
      ),
      QuizModel(
        idCat: 3,
        des: "Môn thể thao yêu thích nhất của bạn là gì ?",
        result: 1,
        A: "Bóng đá",
        B: "Bóng bàn",
        C: "Bóng rổ",
        D: "Bóng cười",
      ),
      QuizModel(
        idCat: 4,
        des: "Gene của ai quyết định giới tính thai nhi ?",
        result: 1,
        A: "Đúng",
        B: "Sai",
        C: "Hỏi ông hàng xóm",
        D: "Không biết",
      ),
      QuizModel(
        idCat: 4,
        des: "Nhiệt độ của lõi trái đất là bao nhiêu ?",
        result: 1,
        A: "100",
        B: "500",
        C: "1000",
        D: "1500",
      ),
      QuizModel(
        idCat: 4,
        des: "Trái đất bao nhiêu tuổi ?",
        result: 1,
        A: "4.54 tỷ năm",
        B: "1 tuổi",
        C: "2 tỷ năm",
        D: "2 tuổi",
      ),
      QuizModel(
        idCat: 4,
        des: "Giá của cuốn sách Mai tôi đi học ?",
        result: 3,
        A: "Tặng miễn phí",
        B: "100K",
        C: "150K",
        D: "200L",
      ),
      QuizModel(
        idCat: 5,
        des:
            "Tác gỉa của cuốn sách Tôi nên làm gì để trở nên hạnh phúc hơn là ai?",
        result: 1,
        A: "Adam Grant",
        B: "Không biết",
        C: "Nam Cao",
        D: "Sir Alex",
      ),
      QuizModel(
        idCat: 5,
        des:
            "Nhà văn Mỹ Dan Brown, bậc thầy của mật mã đã có bao nhiêu tác phẩm được dịch và xuất bản tại Việt Nam ?",
        result: 1,
        A: "1",
        B: "2",
        C: "3",
        D: "4",
      ),
      QuizModel(
        idCat: 5,
        des:
            "Nhà văn bestseller Nicholas Sparks đã có bao nhiêu tác phẩm được chuyển thể thành phim?",
        result: 3,
        A: "1",
        B: "2",
        C: "3",
        D: "0",
      ),
      QuizModel(
        idCat: 5,
        des: "Thời điểm đọc sách tốt nhất là khi nào?",
        result: 2,
        A: "Sáng : 8-9 giờ",
        B: "Tối từ 21-23 giờ",
        C: "Đi vệ sinh",
        D: "Trong mơ",
      ),
      QuizModel(
        idCat: 6,
        des: "Ai là cha của Tony Stark? ",
        result: 3,
        A: "John Stark",
        B: "Howard Stark",
        C: "Adam Stark",
        D: "Ông hàng xóm",
      ),
      QuizModel(
        idCat: 6,
        des: "Nick Fury bị mất một mắt trong hoàn cảnh nào ?",
        result: 1,
        A: "Chiến tranh thế giới thứ I",
        B: "Weapon X",
        C: "Chiến tranh thế giói thứ II",
        D: "Đéo biết",
      ),
      QuizModel(
        idCat: 6,
        des:
            "Nhân vật xuất hiện trong cảnh cuối cùng của phim 'The Avengers' sản xuất năm 2012 là ai ?",
        result: 4,
        A: "Ultron",
        B: "Thanos",
        C: "Galactus",
        D: "Apocalypse",
      ),
      QuizModel(
        idCat: 6,
        des:
            "Iron Man có thể nâng được vật có khối lượng tối đa là bao nhiêu tấn ?",
        result: 3,
        A: "100",
        B: "1000",
        C: "1",
        D: "1500",
      )
    ]);
  }

  void _insertCategories(ModesDao db) {
    db.insertCategories(cats: [
      CategoryModel(
          id: 1, name: "Âm nhạc", des: "Các câu hỏi về đề tài âm nhạc."),
      CategoryModel(
          id: 2, name: "Ẩm thực", des: "Các câu hỏi về đề tài ẩm thực."),
      CategoryModel(
          id: 3, name: "Thể thao", des: "Các câu hỏi về đề tài thể thao."),
      CategoryModel(
          id: 4, name: "Khoa học", des: "Các câu hỏi về đề tài khoa học."),
      CategoryModel(id: 5, name: "Sách", des: "Các câu hỏi về đề tài sách."),
      CategoryModel(id: 6, name: "Film", des: "Các câu hỏi về đề tài phim ảnh")
    ]);
  }
}
