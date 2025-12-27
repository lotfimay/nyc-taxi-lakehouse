{% macro sk(columns) %}

    to_hex(
        md5(
            cast(
                concat_ws(
                    '||',
                    {% for col in columns %}
                        coalesce(cast({{ col }} as varchar), 'NULL')
                        {% if not loop.last %}, {% endif %}
                    {% endfor %}
                ) as varbinary
            )
        )
    )

{% endmacro %}
