

{% macro cents_to_dollars(column_name) %}
    {%- set test_var = column_name | trim -%}
    case when {{test_var}} = 'INSTITUTIONS' then 'test'
    else {{test_var}}
    end
{% endmacro %}


{% macro normsdist_prep(input) %}
  abs({{input}}) / SQRT(2)
{% endmacro %}

{% macro normsdist(Z) %}

    {% set a1 = 2.222332332323 %}
    {% set pA0 = 3.209377589138469472562E03 %}
    {% set pA1 = 3.774852376853020208137E02 %}
    {% set pA2 = 1.138641541510501556495E02 %}
    {% set pA3 = 3.161123743870565596947E00 %}
    {% set pA4 = 1.857777061846031526730E-01 %}

    {% set qA0 = 2.844236833439170622273E03 %}
    {% set qA1 = 1.282616526077372275645E03 %}
    {% set qA2 = 2.440246379344441733056E02 %}
    {% set qA3 = 2.360129095234412093499E01 %}
    {% set qA4 = 1.000000000000000000000E00 %}

    {% set pB0 = 1.23033935479799725272E03 %}
    {% set pB1 = 2.05107837782607146532E03 %}
    {% set pB2 = 1.71204761263407058314E03 %}
    {% set pB3 = 8.81952221241769090411E02 %}
    {% set pB4 = 2.98635138197400131132E02 %}
    {% set pB5 = 6.61191906371416294775E01 %}
    {% set pB6 = 8.88314979438837594118E00 %}
    {% set pB7 = 5.64188496988670089180E-01 %}
    {% set pB8 = 2.15311535474403846343E-08 %}

    {% set qB0 = 1.23033935480374942043E03 %}
    {% set qB1 = 3.43936767414372163696E03 %}
    {% set qB2 = 4.36261909014324715820E03 %}
    {% set qB3 = 3.29079923573345962678E03 %}
    {% set qB4 = 1.62138957456669018874E03 %}
    {% set qB5 = 5.37181101862009857509E02 %}
    {% set qB6 = 1.17693950891312499305E02 %}
    {% set qB7 = 1.57449261107098347253E01 %}
    {% set qB8 = 1.00000000000000000000E00 %}

    {% set pC0 = -6.58749161529837803157E-04 %}
    {% set pC1 = -1.60837851487422766278E-02 %}
    {% set pC2 = -1.25781726111229246204E-01 %}
    {% set pC3 = -3.60344899949804439429E-01 %}
    {% set pC4 = -3.05326634961232344035E-01 %}
    {% set pC5 = -1.63153871373020978498E-02 %}

    {% set qC0 = 2.33520497626869185443E-03 %}
    {% set qC1 = 6.05183413124413191178E-02 %}
    {% set qC2 = 5.27905102951428412248E-01 %}
    {% set qC3 = 1.87295284992346047209E00 %}
    {% set qC4 = 2.56852019228982242072E00 %}
    {% set qC5 = 1.00000000000000000000E00 %}

    {% set pi = 3.141592653589793238462643383 %}
    CASE WHEN CAST({{ Z }} AS FLOAT64) >= 11.0 THEN 1
    WHEN CAST({{ Z }} AS FLOAT64) <= 0.46786 THEN

        {{ Z }} 
        * 
        (
            {{ pA0 }} + {{ pA1 }} * POWER({{ Z }}, 2) + {{ pA2 }} * POWER({{ Z }}, 4) + {{ pA3 }} * POWER({{ Z }}, 6) + {{ pA4 }} * POWER({{ Z }}, 8)
            ) 
        / 
        (
            {{ qA0 }} + {{ qA1 }} * POWER({{ Z }}, 2) + {{ qA2 }} * POWER({{ Z }}, 4) + {{ qA3 }} * POWER({{ Z }}, 6) + {{ qA4 }} * POWER({{ Z }}, 8)
            )
    WHEN CAST({{ Z }} AS FLOAT64) <= 4.0 THEN

        1.0 - EXP(-POWER({{ Z }}, 2)) * ({{ pB0 }} + {{ pB1 }} * {{ Z }} + {{ pB2 }} * POWER({{ Z }}, 2) + {{ pB3 }} * POWER({{ Z }}, 3) + {{pB4}} * POWER({{ Z }}, 4) 
        + {{pB5}} * POWER({{ Z }}, 4) + {{ pB6 }} * POWER({{ Z }}, 6) + {{ pB7}} * POWER({{ Z }}, 7) + {{ pB8 }} * POWER({{ Z }}, 8)) 
        /
        ({{ qB0 }} + {{ qB1 }} * {{ Z }} + {{ qB2 }} * POWER({{ Z }}, 2) + {{ qB3 }} * POWER({{ Z }}, 3) + {{ qB4 }} * POWER({{ Z }}, 4) 
        + {{ qB5 }} * POWER({{ Z }}, 4) + {{ qB6 }} * POWER({{ Z }}, 6) + {{ qB7 }} * POWER({{ Z }}, 7) + {{ qB8 }} * POWER({{Z}}, 8))

    ELSE

        (1 - EXP(-1*POWER({{ Z }}, 2))/ {{Z}} * (1/SQRT({{ pi }}) + 1/POWER({{ Z }}, 2) * 
        (({{pC0}} + {{pC1}}* POWER({{ Z }}, 2) + {{pC2}}* POWER({{ Z }}, 4) + {{pC3}} * POWER({{ Z }}, 6) + {{pC4}} * POWER({{ Z }}, 8) + {{pC5}} * POWER({{ Z }}, 10)) 
        /
        ({{qC0}} + {{qC1}} * POWER({{ Z }}, 2) + {{qC2}} * POWER({{ Z }}, 4)  + {{qC3}} * POWER({{ Z }}, 6) + {{qC4}} * POWER({{ Z }}, 8) + {{qC5}} * POWER({{ Z }}, 10)))))

    END

{% endmacro %}