From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v5] regmap: mmio: Support accelerared noinc operations
Date: Tue, 16 Aug 2022 22:48:32 +0200
Message-ID: <20220816204832.265837-2-linus.walleij@linaro.org>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nCofRxQjD22NC4RudEIRbeqYPsKCnYLSTVWYX+M0X6g=;
        b=GPaEqClZ1+1X/7vnN7sEXAVqstBjVzQUKrDH/oNt95CWyJjh0cnrR8k78ARcl8LitW
         Z/7snZJ0pHkp0Gn4mgmYqkNdC6zNlzPwFS0akx9y18sljKqu43YoV8G6Umugj3SoTgIk
         49rmwW01i/SU+udQFsy2s8VSurSLBurnTPEBRrbIdpLd12jGHECY+Som+j/c2Dd8zrcx
         u1XhRxcq6lWpCbz2BK8xvjH10gr19Erubx/lTS2a504k5Fai2oC7dwsdNKYdZ0SE19+t
         tzb4SF53T65olNfjck8m5RTB+nxZz+HlxHCQsZ4xRTGJywRm0uLaDpiv1jHQ7/vAxB5B
         +KQw==
In-Reply-To: <20220816204832.265837-1-linus.walleij@linaro.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Use the newly added callback for accelerated noinc MMIO
to provide writesb, writesw, writesl, writesq, readsb, readsw,
readsl and readsq.

A special quirk is needed to deal with big endian regmaps: there
are no accelerated operations defined for big endian, so fall
back to calling the big endian operations itereatively for this
case.

The Hexagon architecture turns out to have an incomplete
<asm/io.h>: writesb() is not implemented. Fix this by doing
what other architectures do: include <asm-generic/io.h> into
the <asm/io.h> file.

Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- Halfway throug posting v4 and the build robot complains
  that regmap-mmio.c does not complain on Hexagon. Fix it and
  hope the build robots are happy now.
ChangeLog v3->v4:
- Rebase on regmap for-next
- Notice Andy's patch rewriting *be accessors to use swab16 and
  swab32 and changed my patch accordingly.
- Using swab64 we can actually implement proper 64bit register
  handling as well pretty easily, so fix that while at it.
ChangeLog v2->v3:
- Rebase on kernel v6.0-rc1
ChangeLog v1->v2:
- No changes.
---
 arch/hexagon/include/asm/io.h     |   2 +
 drivers/base/regmap/regmap-mmio.c | 162 ++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index c33241425a5c..8e938dc1ca4b 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -308,6 +308,8 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
 	}
 }
 
+#include <asm-generic/io.h>
+
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index eed488aad1b0..e8d2675463ac 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -16,6 +16,7 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned int val_bytes;
+	bool big_endian;
 
 	bool attached_clk;
 	struct clk *clk;
@@ -165,6 +166,83 @@ static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
 	return 0;
 }
 
+static int regmap_mmio_noinc_write(void *context, unsigned int reg,
+				   const void *val, size_t val_count)
+{
+	struct regmap_mmio_context *ctx = context;
+	int ret = 0;
+	int i;
+
+	if (!IS_ERR(ctx->clk)) {
+		ret = clk_enable(ctx->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * There are no native, assembly-optimized write single register
+	 * operations for big endian, so fall back to emulation if this
+	 * is needed. (Single bytes are fine, they are not affected by
+	 * endianness.)
+	 */
+	if (ctx->big_endian && (ctx->val_bytes > 1)) {
+		switch (ctx->val_bytes) {
+		case 2:
+		{
+			const u16 *valp = (const u16 *)val;
+			for (i = 0; i < val_count; i++)
+				writew(swab16(valp[i]), ctx->regs + reg);
+			goto out_clk;
+		}
+		case 4:
+		{
+			const u32 *valp = (const u32 *)val;
+			for (i = 0; i < val_count; i++)
+				writel(swab32(valp[i]), ctx->regs + reg);
+			goto out_clk;
+		}
+#ifdef CONFIG_64BIT
+		case 8:
+		{
+			const u64 *valp = (const u64 *)val;
+			for (i = 0; i < val_count; i++)
+				writeq(swab64(valp[i]), ctx->regs + reg);
+			goto out_clk;
+		}
+#endif
+		default:
+			ret = -EINVAL;
+			goto out_clk;
+		}
+	}
+
+	switch (ctx->val_bytes) {
+	case 1:
+		writesb(ctx->regs + reg, (const u8 *)val, val_count);
+		break;
+	case 2:
+		writesw(ctx->regs + reg, (const u16 *)val, val_count);
+		break;
+	case 4:
+		writesl(ctx->regs + reg, (const u32 *)val, val_count);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		writesq(ctx->regs + reg, (const u64 *)val, val_count);
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_clk:
+	if (!IS_ERR(ctx->clk))
+		clk_disable(ctx->clk);
+
+	return ret;
+}
+
 static unsigned int regmap_mmio_read8(struct regmap_mmio_context *ctx,
 				      unsigned int reg)
 {
@@ -262,6 +340,87 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
+static int regmap_mmio_noinc_read(void *context, unsigned int reg,
+				  void *val, size_t val_count)
+{
+	struct regmap_mmio_context *ctx = context;
+	int ret = 0;
+	int i;
+
+	if (!IS_ERR(ctx->clk)) {
+		ret = clk_enable(ctx->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (ctx->val_bytes) {
+	case 1:
+		readsb(ctx->regs + reg, (u8 *)val, val_count);
+		break;
+	case 2:
+		readsw(ctx->regs + reg, (u16 *)val, val_count);
+		break;
+	case 4:
+		readsl(ctx->regs + reg, (u32 *)val, val_count);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		readsq(ctx->regs + reg, (u64 *)val, val_count);
+		break;
+#endif
+	default:
+		ret = -EINVAL;
+		goto out_clk;
+	}
+
+	/*
+	 * There are no native, assembly-optimized write single register
+	 * operations for big endian, so fall back to emulation if this
+	 * is needed. (Single bytes are fine, they are not affected by
+	 * endianness.)
+	 */
+	if (ctx->big_endian && (ctx->val_bytes > 1)) {
+		switch (ctx->val_bytes) {
+		case 2:
+		{
+			u16 *valp = (u16 *)val;
+			for (i = 0; i < val_count; i++)
+				valp[i] = swab16(valp[i]);
+			break;
+		}
+		case 4:
+		{
+			u32 *valp = (u32 *)val;
+			for (i = 0; i < val_count; i++)
+				valp[i] = swab32(valp[i]);
+			break;
+		}
+#ifdef CONFIG_64BIT
+		case 8:
+		{
+			u64 *valp = (u64 *)val;
+			for (i = 0; i < val_count; i++)
+				valp[i] = swab64(valp[i]);
+			break;
+		}
+#endif
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+
+out_clk:
+	if (!IS_ERR(ctx->clk))
+		clk_disable(ctx->clk);
+
+	return ret;
+
+	return 0;
+}
+
+
 static void regmap_mmio_free_context(void *context)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -278,6 +437,8 @@ static const struct regmap_bus regmap_mmio = {
 	.fast_io = true,
 	.reg_write = regmap_mmio_write,
 	.reg_read = regmap_mmio_read,
+	.reg_noinc_write = regmap_mmio_noinc_write,
+	.reg_noinc_read = regmap_mmio_noinc_read,
 	.free_context = regmap_mmio_free_context,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
@@ -368,6 +529,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #ifdef __BIG_ENDIAN
 	case REGMAP_ENDIAN_NATIVE:
 #endif
+		ctx->big_endian = true;
 		switch (config->val_bits) {
 		case 8:
 			if (config->io_port) {
-- 
2.37.2

