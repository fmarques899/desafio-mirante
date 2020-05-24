package br.net.mirante.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.net.mirante.entities.Operator;

@Repository
public interface OperatorRepository extends CrudRepository<Operator, Long> {

}