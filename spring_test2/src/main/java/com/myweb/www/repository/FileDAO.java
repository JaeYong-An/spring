package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.domain.FileVO;

public interface FileDAO {

	void insert(FileVO fvo);

	List<FileVO> getFileList(long bno);

	int delete(String uuid);

	List<FileVO> selectListAllFile();
	
}
