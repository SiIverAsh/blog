package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.WenzhangxinxiEntity;
import com.entity.view.WenzhangxinxiView;
import com.entity.vo.WenzhangxinxiVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface WenzhangxinxiDao extends BaseMapper<WenzhangxinxiEntity> {
	
	List<WenzhangxinxiVO> selectListVO(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
	
	WenzhangxinxiVO selectVO(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
	
	List<WenzhangxinxiView> selectListView(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);

	List<WenzhangxinxiView> selectListView(Pagination page,@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
	
	WenzhangxinxiView selectView(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
	
}
