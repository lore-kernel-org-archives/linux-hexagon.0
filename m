From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Thu, 17 Aug 2023 14:38:05 +1000
Message-ID: <875y5e707m.fsf@mail.lhotse>
References: <20230816055010.31534-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oTlj1DPcpOD8ed7Vt2IGAZxoTYSU04OOyEW0nBOL3t4=; b=FKgRpKfjAM3oLK
	lrveyDRsuP0XtMwuLKl56mc22pC9JGwFQ+UxAbxcg4SrCAQuwtsH8iItOX/kvXo7Dsmgwwj7OVgXB
	4FbufWjBGJacIWqlX9HsX8z/IWsyLQX1hc2tHGLfG1OsyRsNyuAjErCBdw0gVvLzGOmSYANsrwmXm
	4EQgahVp4x1vSfNaarBUciNn5s3EZtDORyVLdtUv0mcA6G7F2/PHI/QRRWWuHM9UKfqmxHL2fllP3
	adW1ubUxV0/b6mPHGIakjeIkDvt7dWf4mKTlPql1tMLJ7ipEWrpKWnHVr/qXyTUH36u+pbVIK747n
	HEs+XIYn9Z/mZUffsm4g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1692247099;
	bh=TTioG2ECpny8c1gUsV9lSzzBSbOyxoHgJmKmcWGJJb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XBb7K0DGSY/aWma20FuWJJsaYj/I7WnxTgc1QHrKacwxzHabn8IDVtxnh+u1kir6R
	 0/dCSv6v4j6K+H0n0qfcFvbzDwuMx48my6HmK54JUowGxZTDeBv/LzC/fGdkjM0jbL
	 uhrythOSDp6fSsw5OTIIfIEFFsUSHSrvxpvNZyVXzcV91YnrQwqGxwE4iXdMVpv7PD
	 KJDmjPNi29obujTq193LiorByY4yu6Webks9bDdTMqdbgikcZ6YUA9A+9yqAiDvppy
	 K31/Jqh8vTUknZvmhTxSZipw5CVFpctxK0wQ1Ogxo+krqzabVOtQDHKwv50O+7cmGR
	 NxwruEUcx/hdw==
In-Reply-To: <20230816055010.31534-1-rdunlap@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-

Randy Dunlap <rdunlap@infradead.org> writes:
> There is only one Kconfig user of CONFIG_EMBEDDED and it can be
> switched to EXPERT or "if !ARCH_MULTIPLATFORM" (suggested by Arnd).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
...
>  arch/powerpc/configs/40x/klondike_defconfig          |    2 +-
>  arch/powerpc/configs/44x/fsp2_defconfig              |    2 +-
>  arch/powerpc/configs/52xx/tqm5200_defconfig          |    2 +-
>  arch/powerpc/configs/mgcoge_defconfig                |    2 +-
>  arch/powerpc/configs/microwatt_defconfig             |    2 +-
>  arch/powerpc/configs/ps3_defconfig                   |    2 +-
  
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

...

> diff -- a/init/Kconfig b/init/Kconfig
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
>  
>  	  If unsure, say N.
>  
> -config EMBEDDED
> -	bool "Embedded system"
> -	select EXPERT

This is a crucial detail that could be mentioned in the change log. ie.
that all defconfigs that currently have EMBEDDED=y are currently
selecting EXPERT already.

cheers
