From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Date: Fri, 14 Jul 2023 23:57:06 +0100
Message-ID: <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Om+vkuYZS0OLKEiC"
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689375444;
        bh=P8clI5KtqQRzgFfns22g81I3g6E4+6MLCwEqWyZYU68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjATGNeW2AnMB8iSVCidFlZhH9OfkN7bAt2p7ldacOlxk00MBC0K43n0wGgdC/kES
         5er615dq9DLL0q9cE1VNLaWlbFSi2IfYsicV7umDzTZyH4W2s60ky3l5tGI2zapesZ
         a6IFRb5wsW2IyAbgdPu3qj324ZAqxXKa5uD5MSOHkbg0ycP0RX1WKos7Wx9s9h14c7
         mr09nK6DvKTxBa912H2K859rBf/1exfAJQyuctMgVjw5UcRvPGqHIzg/7kZ1W2WHDS
         fPdS6OedIvs2Ff2PDWFgTKxBrTglm+398FEIc7xd983iXS7+gUDgWarryvZetDtEg3
         d1Xp1VJIV7NTA==
Content-Disposition: inline
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>


--Om+vkuYZS0OLKEiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:10:27PM -0700, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requires
> some core mm changes to function properly.

This seems to break sparc64_defconfig when applied on top of v6.5-rc1:

In file included from /home/broonie/git/bisect/include/linux/mm.h:29,
                 from /home/broonie/git/bisect/net/core/skbuff.c:40:
/home/broonie/git/bisect/include/linux/pgtable.h: In function 'pmd_mkwrite':
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: implicit declaration of function 'pmd_mkwrite_novma'; did you mean 'pte_mkwrite_novma'? [-Werror=implicit-function-declaration]
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~
         pte_mkwrite_novma
/home/broonie/git/bisect/include/linux/pgtable.h:528:9: error: incompatible types when returning type 'int' but 'pmd_t' {aka 'struct <anonymous>'} was expected
  return pmd_mkwrite_novma(pmd);
         ^~~~~~~~~~~~~~~~~~~~~~

The same issue seems to apply with the version that was in -next based
on v6.4-rc4 too.

--Om+vkuYZS0OLKEiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSx0sEACgkQJNaLcl1U
h9Cgsgf+I5DDysBO4SJ+jmxeXww6HYCycJsoc6oA/wVf/wO7aTv89RFcAPpwMOoq
jZKiD/xiUtCMUcNE+ZtCQIYVymIrK1BBcNPzgflt5fa50gm53Hp2mcNFaUeriWjC
x2DfyH1wsfgAjwv14aKu1m59Y7xdhIQWZ4HTezaEFND/3GQTrvGy8tHMDL07GKWz
qL1gMkJ7kYVKEAf86IsSwbDBcSa/SV5cLbsL4S5GEm5K/hQcLwUqSw4WYuMLfNip
Eb4Napl5JYGKJcb/IQIm/PGQbmnKgijPg7mR0lvF6RWZk39wCFxKQizahf6cRCwv
HSMmlXJHILeOK57vaStYZJvapWZzdg==
=/plS
-----END PGP SIGNATURE-----

--Om+vkuYZS0OLKEiC--
