package com.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.entity.WenzhangfenleiEntity;
import com.entity.view.WenzhangfenleiView;
import com.entity.vo.WenzhangfenleiVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;



public interface WenzhangfenleiDao extends BaseMapper<WenzhangfenleiEntity> {
	
	List<WenzhangfenleiVO> selectListVO(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
	
	WenzhangfenleiVO selectVO(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
	
	List<WenzhangfenleiView> selectListView(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);

	List<WenzhangfenleiView> selectListView(Pagination page,@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
	
	WenzhangfenleiView selectView(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
	
}
