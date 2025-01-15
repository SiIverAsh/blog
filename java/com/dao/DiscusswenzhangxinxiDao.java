package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.DiscusswenzhangxinxiEntity;
import com.entity.view.DiscusswenzhangxinxiView;
import com.entity.vo.DiscusswenzhangxinxiVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface DiscusswenzhangxinxiDao extends BaseMapper<DiscusswenzhangxinxiEntity> {
	
	List<DiscusswenzhangxinxiVO> selectListVO(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
	
	DiscusswenzhangxinxiVO selectVO(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
	
	List<DiscusswenzhangxinxiView> selectListView(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);

	List<DiscusswenzhangxinxiView> selectListView(Pagination page,@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
	
	DiscusswenzhangxinxiView selectView(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
	
}
