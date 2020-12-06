package net.shopxx.util;

import java.beans.BeanInfo;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * 根据对象属性的名字和类型，进行对象属性值 的复制
 * 
 */
public class ObjectPropertyUtil {


	/**
	 * 对象属性复制，并生成新的对象
	 * 
	 * @param clzTar
	 * @param srcObj
	 * @return
	 */
	public static <T> T copyField(Class<T> clzTar,Object srcObj) {
		T tar = null;
		try { 
			Class<T> classTar = clzTar;// Class.forName(clzTar);
			Class<?> targetSrc = srcObj.getClass();
			// Field[] fldsSrc = targetSrc.getDeclaredFields();

			BeanInfo infoSrc = java.beans.Introspector.getBeanInfo(targetSrc);
			BeanInfo infoTar = java.beans.Introspector.getBeanInfo(classTar);
			tar = classTar.newInstance();

			PropertyDescriptor[] pdSrc = infoSrc.getPropertyDescriptors();
			PropertyDescriptor[] pdTar = infoTar.getPropertyDescriptors();

			for (PropertyDescriptor pd : pdSrc) {

				String pNameSrc = pd.getName();
				Class<?> type = pd.getPropertyType();
				// System.out.println(type);
				Method read = pd.getReadMethod();
				read.setAccessible(true);
				Object val = read.invoke(srcObj, null);

				for (PropertyDescriptor pd1 : pdTar) {

					String pNameSrc_ = pd1.getName();
					Class<?> type_ = pd1.getPropertyType();

					if (pNameSrc.equals(pNameSrc_) && type.equals(type_)
							&& !pNameSrc.equals("class")) {

						System.out.println(" pName: " + pNameSrc + " val: " + val + " type: " + type);
						System.out.println(" pName: " + pNameSrc_ + " type: " + type_);
						System.out.println("============================");

						Method wMethod = pd1.getWriteMethod();
						wMethod.setAccessible(true);
						wMethod.invoke(tar, val);
					}

				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return tar;
	}

	/**
	 * 对象属性复制，不生成新的对象,值不空时才赋值
	 * 
	 * @param clzTar
	 * @param srcObj
	 * @return
	 */
	public static <T>T copyField(T objTar, Object srcObj) {

		try {
			Class<?> classTar = objTar.getClass();// Class.forName(clzTar);
			Class<?> targetSrc = srcObj.getClass();
			// Field[] fldsSrc = targetSrc.getDeclaredFields();

			BeanInfo infoSrc = java.beans.Introspector.getBeanInfo(targetSrc);
			BeanInfo infoTar = java.beans.Introspector.getBeanInfo(classTar);

			PropertyDescriptor[] pdSrc = infoSrc.getPropertyDescriptors();
			PropertyDescriptor[] pdTar = infoTar.getPropertyDescriptors();

			for (PropertyDescriptor pd : pdSrc) {

				String pNameSrc = pd.getName();
				Class<?> type = pd.getPropertyType();
				// System.out.println(type);
				Method read = pd.getReadMethod();
				read.setAccessible(true);
				Object val = read.invoke(srcObj, null);

				for (PropertyDescriptor pd1 : pdTar) {

					String pNameTar = pd1.getName();
					Class<?> type_ = pd1.getPropertyType();

					if (pNameSrc.equals(pNameTar) && type.equals(type_)
							&& !pNameSrc.equals("class") && null != val) {

						System.out.println(" pName: " + pNameSrc + " val: " + val + " type: " + type);
						System.out.println(" pName: " + pNameTar + " type: " + type_);
						System.out.println("============================");

						Method wMethod = pd1.getWriteMethod();
						wMethod.setAccessible(true);
						wMethod.invoke(objTar, val);
					}

				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return objTar;
	}

}
