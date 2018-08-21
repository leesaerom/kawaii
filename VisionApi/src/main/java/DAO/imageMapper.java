package DAO;

import java.util.List;

import VO.MyImage;

public interface imageMapper {
	public int uploadFile(MyImage image);
	public List<MyImage> showAll();
}
