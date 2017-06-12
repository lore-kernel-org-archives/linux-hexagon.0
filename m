From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 00/27] kbuild, arch: complete UAPI de-coupling and cleanup
 scripts/Makefile.headersinst
Date: Mon, 12 Jun 2017 12:26:54 +0900
Message-ID: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=yYr0Lure2neQvt+hQs3CvYojvU6nBZYLELKUdXhUIxo=; b=P7I
	uqkFOrJH174/aDnDofXSvvpJL92N99vvQ5ZVBWx4OZD+7CZmurJVt0sF1rGiQIG8BF3f8ww9IFVNq
	qzU+mYp6I8jqn8lq0khLR4i6cB723hnCqn5ZfK0YCzGTeyPLzQoE1PRvXq5CdyOhMSqNzBTd6o7Uf
	zpQyBjGTcmPP524rBr5CHFe+3NFllPTSsfuiZ+NYBX4P8XyhKUgGOA7yfofKhXGkoRSaP+fDqqVEH
	yx2EgZmbXGU5IO3BX4odcJ3dapadT4akZClpJzO5CdP6Mf+6wT1cgnXDPMjiKRWLJci1CX+SpZOXf
	GyyXpQMQplWIapmOXlS3j26gTQPdUFg==;
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com v5C3RXP0001077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1497238056;
 bh=ts1X1oTzB74TB+ANontNNTGlMPy7obNMBKfuQnCSTRY=;
 h=From:To:Cc:Subject:Date:From;
 b=OnvcyKHyxY7zwWSOGosXfWqiSRx8o1Z6PiGp+WZka11oPnnZWEIXEcuT/KjQhC9Ri
 W73PHXtHpC1PhZBX+/M2AkIxPmFeHVetqB96oipgGqUDz3cBlWRt+nJ0ES/RjUqLEh
 l3Ucbv04Jo80mtnqZCyjIyOv0lWKGPgjbczDHYMCUqL0xhGoc3M7PoVQbdrOQhwXLW
 OIfw2GnIHPxFBjHzOnGWWlTTAoaOg9fN05+qgeM7SVKSMtOywHqPf3OSPXGNxRtTfn
 43jjy9gU6l1lJ1pcyzkHqJEQvPzmhI7eWULKtGUCr3LGzRYEoMtwdyrt+Wh+FB6Mp/
 izmwXPhuk4+fw==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, Aurelien Jacquiot <a-jacquiot@ti.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Steven


In v4.12-rc1, we had a big progress for headers_install.
All (and only) headers under UAPI directories are exported.
However, asm-generic wrappers are still exceptions because
most of arch/*/include/asm/Kbuild include "generic-y" for
exported headers.  As a result, many of generic-wrappers to be
exported are generated outside UAPI directories.

To finish de-coupling UAPI, "generic-y" for exported headers
should be moved to arch/*/include/uapi/asm/Kbuild.

With those cleanups, the logic of headers_install will become
even simpler.  UAPI will be completely self-contained.

This series is based on v4.12-rc2 tag.

This series touches Kbuild files under arch/.  We have two options
to merge this series.

[1] I will collect Acked-by from arch maintainers, then apply the
    whole series to the Kbuild tree.

[2] I will ask arch maintainers to pick up arch changes (for v4.13),
    then apply Makefile changes to the Kbuild tree (for v4.14).

[1] will finish this work by v4.13, but need to deal with some conflicts.
[2] will allow us to reduce conflicts (still a bit conflicts),
    but take more time to finish this work.

If arch maintainers ack [1], I can manage conflicts
before sending a pull request to Linus.



Masahiro Yamada (27):
  kbuild: remove useless $(gen) variable in Makefile.headersinst
  kbuild: fix comment about dst of headers_{install,check}_all
  kbuild: pass dst= to Makefile.headersinst from top Makefile
  arm64: move generic-y of exported headers to uapi/asm/Kbuild
  ARM: move generic-y of exported headers to uapi/asm/Kbuild
  arc: move generic-y of exported headers to uapi/asm/Kbuild
  blackfin: move generic-y of exported headers to uapi/asm/Kbuild
  c6x: move generic-y of exported headers to uapi/asm/Kbuild
  cris: move generic-y of exported headers to uapi/asm/Kbuild
  h8300: move generic-y of exported headers to uapi/asm/Kbuild
  hexagon: move generic-y of exported headers to uapi/asm/Kbuild
  ia64: move generic-y of exported headers to uapi/asm/Kbuild
  m32r: move generic-y of exported headers to uapi/asm/Kbuild
  m68k: move generic-y of exported headers to uapi/asm/Kbuild
  metag: move generic-y of exported headers to uapi/asm/Kbuild
  nios2: remove unneeded arch/nios2/include/(generated/)asm/signal.h
  nios2: move generic-y of exported headers to uapi/asm/Kbuild
  openrisc: move generic-y of exported headers to uapi/asm/Kbuild
  parisc: move generic-y of exported headers to uapi/asm/Kbuild
  sh: move generic-y of exported headers to uapi/asm/Kbuild
  sparc: move generic-y of exported headers to uapi/asm/Kbuild
  tile: move generic-y of exported headers to uapi/asm/Kbuild
  unicore32: move generic-y of exported headers to uapi/asm/Kbuild
  xtensa: move generic-y of exported headers to uapi/asm/Kbuild
  kbuild: do not include old-kbuild-file from Makefile.headersinst
  kbuild: split exported generic header creation into uapi-asm-generic
  kbuild: remove wrapper files handling from Makefile.headersinst

 Makefile                               | 13 +++++++------
 arch/arc/include/asm/Kbuild            | 25 -------------------------
 arch/arc/include/uapi/asm/Kbuild       | 26 ++++++++++++++++++++++++++
 arch/arm/include/asm/Kbuild            | 17 -----------------
 arch/arm/include/uapi/asm/Kbuild       | 16 ++++++++++++++++
 arch/arm64/include/asm/Kbuild          | 17 -----------------
 arch/arm64/include/uapi/asm/Kbuild     | 16 ++++++++++++++++
 arch/blackfin/include/asm/Kbuild       | 22 ----------------------
 arch/blackfin/include/uapi/asm/Kbuild  | 22 ++++++++++++++++++++++
 arch/c6x/include/asm/Kbuild            | 27 ---------------------------
 arch/c6x/include/uapi/asm/Kbuild       | 26 ++++++++++++++++++++++++++
 arch/cris/include/asm/Kbuild           | 18 ------------------
 arch/cris/include/uapi/asm/Kbuild      | 19 +++++++++++++++++++
 arch/h8300/include/asm/Kbuild          | 27 ---------------------------
 arch/h8300/include/uapi/asm/Kbuild     | 28 ++++++++++++++++++++++++++++
 arch/hexagon/include/asm/Kbuild        | 23 -----------------------
 arch/hexagon/include/uapi/asm/Kbuild   | 24 ++++++++++++++++++++++++
 arch/ia64/include/asm/Kbuild           |  2 --
 arch/m32r/include/asm/Kbuild           |  2 --
 arch/m32r/include/uapi/asm/Kbuild      |  2 ++
 arch/m68k/include/asm/Kbuild           | 12 ------------
 arch/m68k/include/uapi/asm/Kbuild      | 11 +++++++++++
 arch/metag/include/asm/Kbuild          | 24 ------------------------
 arch/metag/include/uapi/asm/Kbuild     | 24 ++++++++++++++++++++++++
 arch/nios2/include/asm/Kbuild          | 25 -------------------------
 arch/nios2/include/asm/signal.h        | 22 ----------------------
 arch/nios2/include/uapi/asm/Kbuild     | 24 ++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild       | 28 ----------------------------
 arch/openrisc/include/uapi/asm/Kbuild  | 29 +++++++++++++++++++++++++++++
 arch/parisc/include/asm/Kbuild         |  5 -----
 arch/parisc/include/uapi/asm/Kbuild    |  4 ++++
 arch/sh/include/asm/Kbuild             | 20 --------------------
 arch/sh/include/uapi/asm/Kbuild        | 20 ++++++++++++++++++++
 arch/sparc/include/asm/Kbuild          |  1 -
 arch/sparc/include/uapi/asm/Kbuild     |  2 ++
 arch/tile/include/asm/Kbuild           | 19 -------------------
 arch/tile/include/uapi/asm/Kbuild      | 19 +++++++++++++++++++
 arch/unicore32/include/asm/Kbuild      | 31 +------------------------------
 arch/unicore32/include/uapi/asm/Kbuild | 28 ++++++++++++++++++++++++++++
 arch/xtensa/include/asm/Kbuild         |  9 ---------
 arch/xtensa/include/uapi/asm/Kbuild    | 10 ++++++++++
 scripts/Makefile.headersinst           | 28 ++++------------------------
 42 files changed, 362 insertions(+), 405 deletions(-)
 delete mode 100644 arch/nios2/include/asm/signal.h

-- 
2.7.4
