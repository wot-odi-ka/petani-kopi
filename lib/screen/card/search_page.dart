import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchBoddy();
  }
}

class SearchBoddy extends StatefulWidget {
  const SearchBoddy({Key? key}) : super(key: key);

  @override
  _SearchBoddyState createState() => _SearchBoddyState();
}

class _SearchBoddyState extends State<SearchBoddy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0d1015),
          title: SizedBox(
            height: 45,
            child: TextField(
              autofocus: true,
              cursorColor: Colors.grey[500],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintText: "Search your coffe...",
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Opacity(
                opacity: .7,
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image(image: AssetImage('assets/images/search.png')),
                )),
            SizedBox(
              height: 40,
            ),
            Text(
              "Type to search ...",
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
