
package com.rafareyeslopez;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @project spring-actuator-metrics
 * @package com.rafareyeslopez
 * @date 2020-05-26
 * @author Rafael Reyes Lopez
 *
 */

@RestController
public class Controller {

	@GetMapping(path = "/")
	public String hello() {
		return "hello from version 2";
	}

}
