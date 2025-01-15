package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.BozhuEntity;
import com.entity.view.BozhuView;
import com.entity.vo.BozhuVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;



public interface BozhuDao extends BaseMapper<BozhuEntity> {
	
	List<BozhuVO> selectListVO(@Param("ew") Wrapper<BozhuEntity> wrapper);
	
	BozhuVO selectVO(@Param("ew") Wrapper<BozhuEntity> wrapper);
	
	List<BozhuView> selectListView(@Param("ew") Wrapper<BozhuEntity> wrapper);

	List<BozhuView> selectListView(Pagination page,@Param("ew") Wrapper<BozhuEntity> wrapper);
	
	BozhuView selectView(@Param("ew") Wrapper<BozhuEntity> wrapper);
	
}
