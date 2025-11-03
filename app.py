import streamlit as st

# Base de données des matières
licence = {
    "L1": [
        {"nom": "Mathématiques générales", "credits": 6},
        {"nom": "Informatique de base", "credits": 8},
        {"nom": "Physique", "credits": 6},
        {"nom": "Statistiques", "credits": 5},
        {"nom": "Anglais", "credits": 4},
        {"nom": "Économie", "credits": 6},
        {"nom": "Électronique", "credits": 10},
        {"nom": "Culture générale", "credits": 5},
        {"nom": "Programmation", "credits": 10}
    ],
    "L2": [
        {"nom": "Base de données", "credits": 6},
        {"nom": "Programmation avancée", "credits": 8},
        {"nom": "Analyse mathématique", "credits": 6},
        {"nom": "Système d’exploitation", "credits": 6},
        {"nom": "Réseaux", "credits": 6},
        {"nom": "Anglais technique", "credits": 4},
        {"nom": "Serveur de stockage", "credits": 10},
        {"nom": "Économie numérique", "credits": 8},
        {"nom": "Algorithmique", "credits": 6}
    ]
}

# Configuration de la page
st.set_page_config(page_title="Calculer ma moyenne")
st.title("🔎 Vérification des crédits")
st.write("Entrez vos moyennes pour chaque matière afin de vérifier la validation de votre année.")

# Sélection du niveau
niveau = st.selectbox("Choisis ton niveau :", ["L1", "L2"])

# Calcul du total théorique
expected_total_credits = sum(m["credits"] for m in licence[niveau])
st.caption(f"Total des crédits pour {niveau} : {expected_total_credits}")

st.write("-----------")

# Formulaire
with st.form(key=f"form_{niveau}"):
    st.subheader(f"Saisir les moyennes pour {niveau}")
    field_keys = []

    for index, matiere in enumerate(licence[niveau], start=1):
        key = f"{niveau}_{index}"
        st.number_input(
            label=f"{index}. {matiere['nom']} ({matiere['credits']} crédits)",
            min_value=0.0,
            max_value=20.0,
            step=0.5,
            value=0.0,
            key=key,
            help="Entrez la moyenne finale (0 à 20)."
        )
        field_keys.append(key)

    # Bouton
    submitted = st.form_submit_button("✅ Vérifier les crédits", key=f"submit_{niveau}")

# --- Traitement après soumission ---
if submitted:
    notes = []
    error_found = False
    error_messages = []

    # Récupération des notes
    for index, matiere in enumerate(licence[niveau], start=1):
        key = f"{niveau}_{index}"
        try:
            moyenne = float(st.session_state.get(key, 0.0))
        except Exception as e:
            moyenne = None
            error_found = True
            error_messages.append(f"Valeur invalide pour '{matiere['nom']}' : {e}")

        if moyenne is None or not (0.0 <= moyenne <= 20.0):
            error_found = True
            error_messages.append(f"La moyenne pour '{matiere['nom']}' doit être entre 0 et 20.")
        else:
            notes.append((matiere, moyenne))

    # Si erreurs
    if error_found:
        st.error("Certaines saisies sont invalides :")
        for m in error_messages:
            st.write("•", m)
    else:
        # Calcul des crédits validés
        total_credits = sum(m["credits"] for m, _ in notes)
        credits_valides = 0

        st.subheader("Résultats par matière")
        for matiere, moyenne in notes:
            if moyenne >= 10.0:
                st.success(f"✔️ {matiere['nom']} — validée ({matiere['credits']} crédits) — moyenne {moyenne}")
                credits_valides += matiere["credits"]
            else:
                st.info(f"❌ {matiere['nom']} — non validée ({matiere['credits']} crédits) — moyenne {moyenne}")

        st.write("---")
        st.info(f"🎯 Crédits validés : **{credits_valides} / {total_credits}**")

        # Décision finale
        if credits_valides == total_credits:
            st.balloons()
            st.success("🎉 Année totalement validée !")
        elif credits_valides >= expected_total_credits * 0.8:
            st.warning("⚠️ Passage conditionnel possible (au moins 80% des crédits).")
        else:
            st.error("❌ Redoublement requis : crédits insuffisants.")

        st.caption(f"(Somme crédits UE utilisée = {total_credits}).")
