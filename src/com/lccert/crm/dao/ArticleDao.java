package com.lccert.crm.dao;

import java.util.Map;

import com.lccert.crm.vo.Article;
import org.apache.log4j.Logger;

/**
 * 物品登记表dao
 * @author tangzp
 *
 */
public interface ArticleDao {
  //查询所以子类的物品名称
	public Map<String,String> getAllArticle();
	//根据物品的id来查询物品名称
	public String getNameById(int id);
	public boolean addArticle(Article article);
	//查询所有父类的名称
	public Map<String,String> getAllParenArticle();
}
