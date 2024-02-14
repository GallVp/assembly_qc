process TIDK_PLOT {
    tag "$meta.id"
    label 'process_single'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' || workflow.containerEngine == 'apptainer' ?
        'https://depot.galaxyproject.org/singularity/tidk:0.2.41--hdbdd923_0':
        'quay.io/biocontainers/tidk:0.2.41--hdbdd923_0' }"

    input:
    tuple val(meta), path(tsv)

    output:
    tuple val(meta), path("*.svg"), emit: svg
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    tidk \\
        plot \\
        --output $prefix \\
        $args \\
        --tsv "$tsv"

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tidk: \$(tidk --version | sed 's/tidk //')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.svg

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tidk: \$(tidk --version | sed 's/tidk //')
    END_VERSIONS
    """
}
