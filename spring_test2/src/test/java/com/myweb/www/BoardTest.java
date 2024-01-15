package com.myweb.www;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.myweb.www.domain.BoardVO;
import com.myweb.www.repository.BoardDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ContextConfiguration(classes = {com.myweb.www.config.RootConfig.class})
@RunWith(SpringJUnit4ClassRunner.class)
public class BoardTest {

	@Inject
	private BoardDAO bdao;
	
	@Test
	public void insertBoard() {
		for(int i=0; i<666; i++) {
			BoardVO bvo = new BoardVO();
			bvo.setTitle("Test title" + i);
			bvo.setWriter("tester"+i);
			bvo.setContent("test"+i+"입니다");
			bdao.insert(bvo);
		}
	}
}
