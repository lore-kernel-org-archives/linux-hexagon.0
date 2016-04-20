From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/23] hexagon: update TODO list
Date: Wed, 20 Apr 2016 10:58:06 +0200
Message-ID: <1461142701-21096-9-git-send-email-linus.walleij@linaro.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffHBsJQ9fpDQDaD35C/GFrPCvWHnZVBYA7CAsX0cGe4=;
        b=FJJtkQgtR1ORbhIRrSihfHXcA/W8mHjqjDWhsMyTXAc73TjpIXys3HgPsuaqbTJxcF
         kj6IiEs6E57beNoJ8Nzu8VxwP41Yb1wcOHs9VcBm/ilCDk9qOBa8uchIU5YMLzUF//Wa
         mEGogPKE2Snxu44whRxHR+ygpgxxn7ynwC9Ls=
In-Reply-To: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

The symbol that will be selected when GPIO is implemented
for Hexagon will be GPIOLIB, we have removed
ARCH_REQUIRE_GPIOLIB and ARCH_WANT_OPTIONAL_GPIOLIB.

Cc: Michael B=C3=BCsch <m@bues.ch>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Various arch maintainers:

either ACK this and I will merge it into the GPIO tree for v4.7
anticipating no clashes, or you wait until I have the enabling patch
upstream (patch 1 in this series, removing deps on
ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
merge it to your arch trees yourselves for late v4.7
(post GPIO tree merge) or for v4.8.

You can also ask me for an immutable branch if you prefer that, I
will put the enabling patch on a branch and the patch for your arch
on top and ask you to pull it.

Select your option from the menu, silence probably means I will
merge it to the GPIO tree. Unless you are X86 or ARM in which case
I will be cautious.
---
 arch/hexagon/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 57298e7b4867..1941e4baaee6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -8,8 +8,7 @@ config HEXAGON
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	# select ARCH_HAS_CPU_IDLE_WAIT
-	# select ARCH_WANT_OPTIONAL_GPIOLIB
-	# select ARCH_REQUIRE_GPIOLIB
+	# select GPIOLIB
 	# select HAVE_CLK
 	# select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_ATOMIC64
--=20
2.4.11

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
