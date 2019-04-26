package com.web.ncm.service;

import java.util.List;
import java.util.Map;

import com.web.ncm.domain.BoardDTO;
import com.web.ncm.domain.CommentDTO;
import com.web.ncm.domain.ReCommentDTO;

public interface BoardService {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception;
	public int selectFreeBoardCount() throws Exception;
	public BoardDTO selectWriteView(int num) throws Exception;
	public int updateFreeBoardViewcnt(int num) throws Exception;
	public int updateFreeBoard(BoardDTO dto) throws Exception;
	public int deleteFreeBoard(int num) throws Exception;
	public String selectHasRecommendHistory(Map<String, String> map) throws Exception;
	public int insertRecommendHistory(Map<String, String> map) throws Exception;
	public int updaetFreeBoardRecommend(Map<String, String> map) throws Exception;
	public int insertFreeBoardComment(CommentDTO dto) throws Exception;
	public List<CommentDTO> selectFreeBoardComments(int num) throws Exception;
	public List<CommentDTO> selectFreeBoardComments_popular(int num) throws Exception;
	public int insertFreeBoardReComment(ReCommentDTO dto) throws Exception;
	public List<ReCommentDTO> selectFreeBoardReComments(int num) throws Exception;
	public List<CommentDTO> selectFreeBoardCommentsCount(int num) throws Exception;
	public int updateFreeBoardComment(CommentDTO dto) throws Exception;
	public int deleteFreeBoardComment(int num) throws Exception;
	public int deleteFreeBoardReComments(int num) throws Exception;
	public int updateFreeBoardReComment(ReCommentDTO dto) throws Exception;
	public int deleteFreeBoardReComment(int num) throws Exception;
	public String selectHasCommentRecommendHistory(Map<String, String> map) throws Exception;
	public int insertCommentRecommendHistory(Map<String, String> map) throws Exception;
	public int updateFreeBoardCommentRecommend(Map<String, String> map) throws Exception;
	public List<BoardDTO> selectFreeBoardToday() throws Exception;
	public List<BoardDTO> selectFreeBoardWeek(Map<String, String> map) throws Exception;
	public int insertVideoBoard(BoardDTO dto) throws Exception;
	public BoardDTO selectVideoView(int num) throws Exception;
	public int updateVideoBoardViewcnt(int num) throws Exception;
	public List<BoardDTO> selectVideoBoard(Map<String, Integer> page) throws Exception;
	public int selectVideoBoardCount() throws Exception;
	public int updateVideoBoard(BoardDTO dto) throws Exception;
	public int deleteVideoBoard(int num) throws Exception;
	public int updateVideoBoardRecommend(Map<String, String> map) throws Exception;
	public int insertVideoBoardComment(CommentDTO dto) throws Exception;
	public List<CommentDTO> selectVideoBoardComments(int num) throws Exception;
	public List<CommentDTO> selectVideoBoardComments_popular(int num) throws Exception;
	public int insertVideoBoardReComment(ReCommentDTO dto) throws Exception;
	public List<ReCommentDTO> selectVideoBoardReComments(int num) throws Exception;
	public List<CommentDTO> selectVideoBoardCommentsCount(int num) throws Exception;
	public int updateVideoBoardCommentRecommend(Map<String, String> map) throws Exception;
	public int updateVideoBoardComment(CommentDTO dto) throws Exception;
	public int updateVideoBoardReComment(ReCommentDTO dto) throws Exception;
	public int deleteVideoBoardComment(int num) throws Exception;
	public int deleteVideoBoardReComment(int num) throws Exception;
	public int deleteVideoBoardReComments(int num) throws Exception;
	public List<BoardDTO> selectVideoBoardToday() throws Exception;
	public List<BoardDTO> selectVideoBoardWeek(Map<String, String> map) throws Exception;
}
