package cn.renlm.hints;

import org.springframework.aot.hint.RuntimeHints;
import org.springframework.aot.hint.RuntimeHintsRegistrar;

/**
 * （运行时）资源注册
 * 
 * @author RenLiMing(任黎明)
 *
 */
public class MyRuntimeHints implements RuntimeHintsRegistrar {

	@Override
	public void registerHints(RuntimeHints hints, ClassLoader classLoader) {
		hints.resources().registerPattern("keyStore.jks");
	}

}
