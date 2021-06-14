package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Livre;

/**
 * Servlet implementation class Bibliotheque
 */
@WebServlet(
		name = "bibliotheque",
		urlPatterns = {
				"/bibliotheque",
				""
		})
public class Bibliotheque extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bibliotheque() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("action") != null && request.getParameter("reference") != null) {
			// Si action = delete, je suprrime mon livre 
			if(request.getParameter("action").equals("delete")) {
				delLivre(request.getParameter("reference"));
			// Si action = modify, je modifie ses données.
			} else if(request.getParameter("action").equals("modify")) {
				request.setAttribute("modifLivre", find(request.getParameter("reference")));
			}
		}
		request.setAttribute("bibliotheque", this.bibliotheque);
		this.getServletContext().getRequestDispatcher("/jsp/bibliotheque.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("to") != null && request.getParameter("to").equals("add")) {
		// Si to = add ; J'ajoute un livre.
		Livre livren = new Livre(request.getParameter("reference"), request.getParameter("titre"), request.getParameter("auteur"));
		this.bibliotheque.add(livren);
		} else if (request.getParameter("to") != null && request.getParameter("to").equals("mod")) {
		// Si to = mod ; Je modifie le livre.
			Livre livre = find(request.getParameter("reference"));
			livre.setTitre(request.getParameter("titre"));
			livre.setAuteur(request.getParameter("auteur"));
		}
		response.sendRedirect(request.getContextPath());
	}

	public void init() throws ServletException {
		super.init();
		getBibliotheque();
	} 
	
	private ArrayList<Livre> bibliotheque = new ArrayList<Livre>();
	
	private ArrayList<Livre> getBibliotheque() {
		Livre livre1 = new Livre("ABCDEF", "Voyage au bout de la nuit", "Louis-Ferdinand Celine");
		Livre livre2 = new Livre("GHIJKL", "Protagoras", "Platon");
		Livre livre3 = new Livre("MNOPQR", "Alcool", "Guillaume Appolinaire");
		
		this.bibliotheque.add(livre1);
		this.bibliotheque.add(livre2);
		this.bibliotheque.add(livre3);
		
		return bibliotheque;
	}
	
	private Livre find(String ref) {
		
		for(Livre livre : this.bibliotheque) {
			if(livre.getReference().equals(ref)) {
				return livre;
			}
	}
	return null;
}
	
	private void delLivre(String ref) {
		
		Livre livre = find(ref);
		
		if(livre != null) {
			this.bibliotheque.remove(livre);
		}
	}
}
