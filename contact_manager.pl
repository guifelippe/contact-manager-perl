sub create_contact {
    my ($name, $phone) = @_;
    return "$name,$phone\n";
}

sub add_contact {
    my ($contact) = @_;
    
    open(my $file, '>>', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    print $file $contact;
    close($file);
}

sub list_contacts {
    open(my $file, '<', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    
    while (my $line = <$file>) {
        chomp $line;
        my ($name, $phone) = split(',', $line);
        print "Nome: $name, Telefone: $phone\n";
    }
    
    close($file);
}

sub update_contact {
    print "Digite o nome do contato que você deseja atualizar: ";
    my $name = <>;
    chomp $name;

    my @updated_contacts;
    
    open(my $file, '<', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    
    while (my $line = <$file>) {
        chomp $line;
        my ($contact_name, $phone) = split(',', $line);
        
        if ($contact_name eq $name) {
            print "Digite o novo nome: ";
            my $new_name = <>;
            chomp $new_name;
            print "Digite o novo número de telefone: ";
            my $new_phone = <>;
            chomp $new_phone;
            
            push @updated_contacts, create_contact($new_name, $new_phone);
        } else {
            push @updated_contacts, $line;
        }
    }
    
    close($file);
    
    open($file, '>', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    print $file $_."\n" for @updated_contacts;
    close($file);
}

sub delete_contact {
    print "Digite o nome do contato que você deseja excluir: ";
    my $name = <>;
    chomp $name;

    my @updated_contacts;
    
    open(my $file, '<', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    
    while (my $line = <$file>) {
        chomp $line;
        my ($contact_name, $phone) = split(',', $line);
        
        if ($contact_name ne $name) {
            push @updated_contacts, $line;
        }
    }
    
    close($file);
    
    open($file, '>', 'contacts.txt') or die "Não foi possível abrir o arquivo: $!";
    print $file $_."\n" for @updated_contacts;
    close($file);
}

while (1) {
    print "Escolha uma opção:\n";
    print "1. Adicionar Contato\n";
    print "2. Listar Contatos\n";
    print "3. Atualizar Contato\n";
    print "4. Excluir Contato\n";
    print "5. Sair\n";

    my $choice = <>;
    chomp $choice;

    if ($choice eq '1') {
        print "Nome: ";
        my $name = <>;
        chomp $name;
        print "Telefone: ";
        my $phone = <>;
        chomp $phone;
        
        my $contact = create_contact($name, $phone);
        add_contact($contact);
    } elsif ($choice eq '2') {
        list_contacts();
    } elsif ($choice eq '3') {
        update_contact();
    } elsif ($choice eq '4') {
        delete_contact();
    } elsif ($choice eq '5') {
        last;
    } else {
        print "Opção inválida. Tente novamente.\n";
    }
}