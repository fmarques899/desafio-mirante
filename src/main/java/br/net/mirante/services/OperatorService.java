package br.net.mirante.services;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import br.net.mirante.entities.AppUser;
import br.net.mirante.entities.Operator;
import br.net.mirante.entities.Profile;
import br.net.mirante.enums.ProfileTypesEnum;
import br.net.mirante.repository.AppUserRepository;
import br.net.mirante.repository.OperatorRepository;
import br.net.mirante.repository.ProfileRepository;
import br.net.mirante.viewmodels.request.OperatorRequest;
import br.net.mirante.viewmodels.response.OperatorResponse;

@Component
public class OperatorService {

	@Autowired
	private OperatorRepository operatorRepository;
	
	@Autowired
	private AppUserRepository appUserRepository;
	
	@Autowired
	private ProfileRepository profileRepository;
	
	public List<OperatorResponse> list() {
		List<OperatorResponse> operatorsRsp = new ArrayList<OperatorResponse>();
		
		for(Operator operator : operatorRepository.findAll()) {
			OperatorResponse operatorResponse = new OperatorResponse(operator);
			operatorsRsp.add(operatorResponse);
		}
		
		return operatorsRsp;
	}
	
	public void register(OperatorRequest operatorRequest) {
		
		Optional<Profile> profile = profileRepository.findById(Long.valueOf(ProfileTypesEnum.MANAGER.type));
		
		AppUser appUser = parseUser(
				operatorRequest.getLogin(), 
				operatorRequest.getPassword(), profile.get());
		
		appUserRepository.save(appUser);
		
		Operator operator = parseOperator(operatorRequest, appUser);
		
		operatorRepository.save(operator);
		
	}
	
	public OperatorResponse detail(Long id) {
		return new OperatorResponse(operatorRepository.findById((id)).get());
	}
	
	public void remove(Long id) {
		Optional<Operator> operator = operatorRepository.findById(id);
		operatorRepository.deleteById(id);
		appUserRepository.delete(operator.get().getAppUser());
	}
	public OperatorResponse update(OperatorRequest operatorRequest) {
		Optional<Operator> operator = operatorRepository.findById(operatorRequest.getId());
		
		operator.get().setName(operatorRequest.getName());
		operatorRepository.save(operator.get());
		OperatorResponse operatorResponse = new OperatorResponse(operator.get()); 
		
		
		return operatorResponse;
	}
	
	private AppUser parseUser(String login, String password, Profile profile) {
		AppUser appUser = new AppUser();
		
		appUser.setLogin(login);
		appUser.setPassword(new BCryptPasswordEncoder().encode(password));
		appUser.setProfile(profile);
		
		return appUser;
	}
	
	private Operator parseOperator(OperatorRequest operatorRequest, AppUser appUser) {
		Operator operator = new Operator();
		
		operator.setName(operatorRequest.getName());
		operator.setCreationDate(new GregorianCalendar());
		operator.setAppUser(appUser);
		
		return operator;
	}
	
	
	
}
