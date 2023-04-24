local 8ucchiman = {}

function 8ucchiman.get_temp_list()

    8ucchiman.temp_dir = fs.normalize(8ucchiman.temp_dir)

end


function 8ucchiman.setup(config)
    vim.validate({
        config = {config, 'table'}
    })
end

return 8ucchiman
