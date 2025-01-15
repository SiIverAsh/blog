package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.JubaotousuEntity;
import com.entity.view.JubaotousuView;
import com.entity.vo.JubaotousuVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface JubaotousuDao extends BaseMapper<JubaotousuEntity> {
	
	List<JubaotousuVO> selectListVO(@Param("ew") Wrapper<JubaotousuEntity> wrapper);
	
	JubaotousuVO selectVO(@Param("ew") Wrapper<JubaotousuEntity> wrapper);
	
	List<JubaotousuView> selectListView(@Param("ew") Wrapper<JubaotousuEntity> wrapper);

	List<JubaotousuView> selectListView(Pagination page,@Param("ew") Wrapper<JubaotousuEntity> wrapper);
	
	JubaotousuView selectView(@Param("ew") Wrapper<JubaotousuEntity> wrapper);
	
}
