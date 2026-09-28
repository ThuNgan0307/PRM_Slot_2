import 'package:flutter/material.dart';
import '../models/task.dart';
class HomeScreen extends StatefulWidget {
 const HomeScreen({super.key});
 @override
 State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
 // 1. Khai báo danh sách Task rỗng
 final List<Task> _tasks = [];
 
 // 2. Controller để lấy dữ liệu từ ô nhập
 final TextEditingController _controller = TextEditingController();
 // 3. Hàm thêm Task mới
 void _addTask() {
 String text = _controller.text.trim();
 if (text.isNotEmpty) {
 setState(() {
 _tasks.add(Task(title: text));
 _controller.clear(); // Xóa chữ sau khi thêm
 });
 FocusScope.of(context).unfocus(); // Ẩn bàn phím
 }
 }
 @override
 Widget build(BuildContext context) {
 // Tính toán số task hoàn thành cho Bước 8
 int completedCount = _tasks.where((t) => t.isDone).length;
 return Scaffold(
 appBar: AppBar(
 title: const Text("Student Task Manager"),
 backgroundColor: Colors.blueAccent,
 foregroundColor: Colors.white,
 ),
 body: Padding(
 padding: const EdgeInsets.all(16.0),
 child: Column(
 children: [
 // Thống kê nhanh
 Text("Hoàn thành: $completedCount / ${_tasks.length}"),
 const SizedBox(height: 10),
 
 // Ô nhập liệu (TextField)
 TextField(
 controller: _controller,
 decoration: InputDecoration(
 labelText: "Nhập tên công việc...",
 border: const OutlineInputBorder(),
 suffixIcon: IconButton(
 icon: const Icon(Icons.add),
 onPressed: _addTask,
 ),
 ),
 ),
 const SizedBox(height: 20),
 
 // Danh sách hiển thị (ListView)
 Expanded(
 child: _tasks.isEmpty 
 ? const Center(child: Text("Chưa có công việc nào!"))
 : ListView.builder(
 itemCount: _tasks.length,
 itemBuilder: (context, index) {
 return _buildTaskItem(_tasks[index], index);
 },
 ),
 ),
 ],
 ),
 ),
 );
 }

 Widget _buildTaskItem(Task task, int index) {
 return Card(
 elevation: 2,
 child: ListTile(
 leading: Checkbox(
 value: task.isDone,
 onChanged: (bool? value) {
 setState(() {
 task.isDone = value!;
 });
 },
 ),
 title: Text(
 task.title,
 style: TextStyle(
 decoration: task.isDone ? TextDecoration.lineThrough : null,
 color: task.isDone ? Colors.grey : Colors.black,
 ),
 ),
 trailing: IconButton(
 icon: const Icon(Icons.delete, color: Colors.redAccent),
 onPressed: () {
 setState(() {
 _tasks.removeAt(index);
 });
 },
 ),
 ),
 );
 }
} // Kết thúc _HomeScreenState