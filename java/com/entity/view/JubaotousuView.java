package com.entity.view;

import com.entity.JubaotousuEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 


@TableName("jubaotousu")
public class JubaotousuView  extends JubaotousuEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public JubaotousuView(){
	}
 
 	public JubaotousuView(JubaotousuEntity jubaotousuEntity){
 	try {
			BeanUtils.copyProperties(this, jubaotousuEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}
}
