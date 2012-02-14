package fr.univartois.ili.fsnet.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

/*
 * Author : Yoann VASSEUR
 * 
 * 
 */

@Entity
public class DegreeCV implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@GeneratedValue (strategy = GenerationType.IDENTITY)
	@Id
	private long id;

	private int postBacValue;
	private String grade;

	@OneToMany (mappedBy="degree")
	private List<AssociationDateDegreeCV> myCVs = new ArrayList<AssociationDateDegreeCV>();

	@OneToOne
	private EstablishmentCV ets;

	public DegreeCV() {

	}

	/**
	 * @return the id
	 */
	public long getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * @return the postBacValue
	 */
	public int getPostBacValue() {
		return postBacValue;
	}

	/**
	 * @param postBacValue
	 *            the postBacValue to set
	 */
	public void setPostBacValue(int postBacValue) {
		this.postBacValue = postBacValue;
	}

	/**
	 * @return the grade
	 */
	public String getGrade() {
		return grade;
	}

	/**
	 * @param grade
	 *            the grade to set
	 */
	public void setGrade(String grade) {
		this.grade = grade;
	}

	/**
	 * @return the ets
	 */
	public EstablishmentCV getEts() {
		return ets;
	}

	/**
	 * @param ets
	 *            the ets to set
	 */
	public void setEts(EstablishmentCV ets) {
		this.ets = ets;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * @return the myCVs
	 */
	public List<AssociationDateDegreeCV> getAssociationDateDegreeCV() {
		return myCVs;
	}

	/**
	 * @param myCVs
	 *            the myCVs to set
	 */
	public void setAssociationDateDegreeCV(
			List<AssociationDateDegreeCV> myAssociationDateDegreeCV) {
		this.myCVs = myAssociationDateDegreeCV;
	}

}
