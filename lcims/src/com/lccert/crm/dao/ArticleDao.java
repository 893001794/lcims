package com.lccert.crm.dao;

import java.util.Map;

import com.lccert.crm.vo.Article;
import org.apache.log4j.Logger;

/**
 * ��Ʒ�ǼǱ�dao
 * @author tangzp
 *
 */
public interface ArticleDao {
  //��ѯ�����������Ʒ����
	public Map<String,String> getAllArticle();
	//������Ʒ��id����ѯ��Ʒ����
	public String getNameById(int id);
	public boolean addArticle(Article article);
	//��ѯ���и��������
	public Map<String,String> getAllParenArticle();
}
