From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Date: Wed, 3 May 2023 13:06:44 +0200
Message-ID: <ZFJARBDqWPLSy7Ge@localhost.localdomain>
References: <20230429063348.125544-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683112007;
        bh=1Z/abXjYScbaeQJORhJfZ1yaBTS2vU/U1cufhR2GD0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYeRD57ViS93rxSgHpAWB7YMqFMUVx8+EiMfSRn6yQEG7G9RSDQSNSSe1sxzZ3BLo
         GvrB3gAjIST0ilFZUg8IMfwBDx8wfH+KA+j3pBm5lWI8UmkhRuaPcCrBRvajh/kKlf
         sc97elHz9FlAP3leMT4UaefDRJMGkLzMHZE6FdoaOvmUUjuDHCL58u0eFmESKWCS4j
         iTu0lEr+kmh/c3tzKSar0Ap1ePkXfG5K61exCSLbCF+9ApT/2au8DOYFlhGDOEhdXg
         2pQvwMWVokBgoPnt+ruSQN7Puaw5HnfRo4DOOVEE3FkCyWkRa5+PjlZzOTI1BYYKE3
         QatkVXcriRXBA==
Content-Disposition: inline
In-Reply-To: <20230429063348.125544-1-npiggin@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.o

Le Sat, Apr 29, 2023 at 04:33:48PM +1000, Nicholas Piggin a =E9crit :
> This option was created in commit 554b0004d0ec4 ("vtime: Add
> HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
>=20
> The cputime_t type has since been removed, so this doesn't have any
> meaning. Remove it.

Well, cputime_t has disappeared but not the u64 type used
for task/cpu time accounting.

But now we have the vtime seqcount. Though we already had it
when we introduced that Kconfig switch so I can't remember why
this was necessary :-(

It _looks_ OK but I might be missing something...

Thanks.
