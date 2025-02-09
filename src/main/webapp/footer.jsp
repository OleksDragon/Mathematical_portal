<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-dark text-white text-center py-3 mt-auto">
    &copy; <span id="current-year"></span> Zolotopup
</footer>

<script>
    // Устанавливаем текущий год в футер
    document.getElementById('current-year').textContent = new Date().getFullYear();
</script>
