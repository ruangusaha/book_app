import 'dart:async';
import 'dart:convert';

import 'package:book_apps/controllers/book_controller.dart';
import 'package:book_apps/models/book_list_response.dart';
import 'package:book_apps/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Katalog Buku"),
      ),
      body: Consumer<BookController>(
        child: Center(child: CircularProgressIndicator()),
        builder: (context, controlller, child) => Container(
          child: bookController!.bookList == null
              ?  child
              : ListView.builder(
                  itemCount: bookController!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailBookPage(
                              isbn: currentBook.isbn13!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.network(
                            currentBook.image!,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentBook.title!),
                                  Text(currentBook.subtitle!),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(currentBook.price!)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
