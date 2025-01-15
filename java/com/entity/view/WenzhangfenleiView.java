package com.entity.view;

import com.entity.WenzhangfenleiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 


@TableName("wenzhangfenlei")
public class WenzhangfenleiView  extends WenzhangfenleiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public WenzhangfenleiView(){
	}
 
 	public WenzhangfenleiView(WenzhangfenleiEntity wenzhangfenleiEntity){
 	try {
			BeanUtils.copyProperties(this, wenzhangfenleiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}
}
