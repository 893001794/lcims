package com.temp;


import java.awt.BorderLayout;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;

public class tableTest {

 private static JTable table;

 /**
  * @param args
  */
 public static void main(String[] args) {
  // TODO Auto-generated method stub
  tabFrame frame = new tabFrame();
  frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
  frame.setVisible(true);
 }
}

class tabFrame extends JFrame {
 private JTable table;

 public tabFrame() {
  setTitle("表格模型测试");
  setSize(400, 300);
  getContentPane().setLayout(null);

  final JScrollPane scrollPane = new JScrollPane();
  scrollPane.setBounds(65, 10, 255, 201);
  getContentPane().add(scrollPane);

  TableModel model = new InvestmentTableModel(30, 5, 10); //创建表格模型对象
  table = new JTable(model); //创建表格,载入表格模型
  scrollPane.setViewportView(table); //在滚动框中加入表格
 }
}

/**
 * 表格模型类
 */
class InvestmentTableModel extends AbstractTableModel {
 private int years;
 private int minRate;
 private int maxRate;
 private static double INITIAL_BALANCE = 100000.0;

 public InvestmentTableModel(int y, int r1, int r2) {
  years = y;
  minRate = r1;
  maxRate = r2;
 }

 /**
  * 设置行数
  */
 public int getRowCount() {
  return years;
 }

 /**
  * 设置列数
  */
 public int getColumnCount() {
  return maxRate - minRate + 1;
 }

 /**
  * 填充各单元格值
  */
 public Object getValueAt(int r, int c) {
  double rate = (c + minRate) / 100.0;
  int nperiods = r;
  double futurBalance = INITIAL_BALANCE * Math.pow(1 + rate, nperiods);
  return String.format("%.2f", futurBalance);
 }

 /**
  * 设定列名
  */
 public String getColumnName(int c) {
  return (c + minRate) + "%";
 }
}


