From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] ARM, hexagon, c6x: build: fix usage of CFLAGS_MODULE,
 LDFLAGS_MODULE
Date: Mon,  9 Oct 2017 23:35:12 +0900
Message-ID: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xQGzJ+033i6aYM2tCD/nli1iygceXJac8iE075kkRRg=; b=aBf
	tYC9/xdUtO1kiuFzDwN9ok90idEEyIaUdWOtPYgI+rbVFS9ukiV0kssFSYjWHtWr3FBnt8lV09Av4
	tFhaDIH0t1YWabw8096ThIkl409mVq57LoYzfCA/o5JC7kmp7ILanbHZYlPEQwchYy4Va6jxb85M8
	q03CuQ0L1KIfLSK0xuGy3KPHaRokMWLnIn0UyABZhlzMJJMwEyvpZGlb0YOpYA8BjRB4p65nSEceA
	Nem+hCJvv7TjjGYfQuvM0uP5v58rGlu3TbX1ojvYUyW3Hqf7Uk1sXjbiT8K807wX/wWcxxGcCqlBz
	7RZXFpS2AQ0vV9V2Wc50EjRv2K+xRgA==;
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com v99EZVZD018442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1507559732;
 bh=YbwqlbK2icG9CZTAD7DbJINfKas7ZSajv1PV1WyZNpc=;
 h=From:To:Cc:Subject:Date:From;
 b=pqQsFcDnjMDZ2EyT78//aU2RJ3mZAAZ1QauiycFzl7JV1B2CnfyEzkfhRQBp2u0zN
 Qdp2oHolgHmOzYsV3MhALZxz++s9NTxKOHJHtw//QhwGlI7wdnEoSmYjEBpEhtIsue
 YDqL2T/bkhyZ5y2YF7V7ILBEQ6q625x/ekF8eUkLZZOLDQnH80ypdGK1Zplu2FO77H
 IwHxPHnLHHRn4PDAjJOJBUhVWk7fWt6YGUYeNjAFkYM3qiTgOVWUFwnPQReLHQh6mR
 SkrNGkH4IAIZjdcuYMB5qiveKh31UJmArww9BdhmmvMxBScYYUxQ9NpIeje/O9qQk6
 gPazZKedtJyHQ==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Salter <msalter@redhat.com>, Russell King <linux@armlinux.org.uk>, Richard Kuo <rkuo@codeaurora.org>, linux-arm-kernel@lists.infradead.org

CFLAGS_MODULE, AFLAGS_MODULE, and LDFLAGS_MODULE are supposed
to be set by users.

In-kernel Makefile must use KBUILD_ prefixed variables.

This is explained in Documentation/kbuild/{kbuild.txt, makefiles.txt}

Most of architectures follow the rule, but I found violations
in ARM, hexagone, and c6x.

Fix them.



Masahiro Yamada (3):
  ARM: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
  hexagon: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
  c6x: add KBUILD_ prefix to CFLAGS_MODULE

 arch/arm/Makefile     | 6 +++---
 arch/c6x/Makefile     | 2 +-
 arch/hexagon/Makefile | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
