package com.mk.fitter.api.common.oauth.VO;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;

import com.mk.fitter.api.common.oauth.Role;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class CustomOAuth2User extends DefaultOAuth2User {
	private int uid;
	private String nickname;
	private String email;
	private Role role;

	/**
	 * Constructs a {@code DefaultOAuth2User} using the provided parameters.
	 *
	 * @param authorities      the authorities granted to the user
	 * @param attributes       the attributes about the user
	 * @param nameAttributeKey the key used to access the user's &quot;name&quot; from
	 *                         {@link #getAttributes()}
	 */
	public CustomOAuth2User(Collection<? extends GrantedAuthority> authorities,
		Map<String, Object> attributes, String nameAttributeKey,
		int uid, String nickname, String email, Role role) {
		super(authorities, attributes, nameAttributeKey);
		this.uid = uid;
		this.nickname = nickname;
		this.email = email;
		this.role = role;
	}
}
