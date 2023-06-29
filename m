From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 12/12] fbdev/core: Define empty fb_firmware_edid() in <linux/fb.h>
Date: Thu, 29 Jun 2023 13:45:51 +0200
Message-ID: <20230629121952.10559-13-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1EPhwvEq31eQQzrYtIsQXTt/XpY0djP9Otjk0JmQCc=;
        b=Dub84nZmbr1BGiuBX3aLZCTa/8FoWtNS4BzLIrTk5qvczeKCFX53em1kSbWeLcAyIspbMx
        j6KHULUkYWyNqKDLvuCO97srdnBXPf6V9M5RJtPm/H/f0wvATtksA3VMvLECaNAMn8RMxS
        gxDb1nO4bNmBncRGAjcZ0s/8rYkvx4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1EPhwvEq31eQQzrYtIsQXTt/XpY0djP9Otjk0JmQCc=;
        b=3Y1jfeE0PeJBr+WAivUH1Npe9jamuIgzZi4hsiB1oUlsIjSgHaYMy5c5OmGy6U7+S8zHKp
        tX1gbKFXmHiTluBA==
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-arch@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Randy Dunlap <rdunlap@infradead.org>

Move the empty declaration of fb_firmware_edid() to <linux/fb.h>.
Follow common style and avoid the overhead of exporting the symbol.
No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/video/fbdev/core/fbmon.c |  7 +------
 include/linux/fb.h               | 10 +++++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 9ae063021e431..d45bd8a18c2f2 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1496,13 +1496,8 @@ const unsigned char *fb_firmware_edid(struct fb_info *info)
 
 	return edid;
 }
-#else
-const unsigned char *fb_firmware_edid(struct fb_info *info)
-{
-	return NULL;
-}
-#endif
 EXPORT_SYMBOL(fb_firmware_edid);
+#endif
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5ffd2223326bf..e949532ffc109 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -761,7 +761,6 @@ extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
-extern const unsigned char *fb_firmware_edid(struct fb_info *info);
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
@@ -774,6 +773,15 @@ extern int of_get_fb_videomode(struct device_node *np,
 extern int fb_videomode_from_videomode(const struct videomode *vm,
 				       struct fb_videomode *fbmode);
 
+#if defined(CONFIG_FIRMWARE_EDID)
+const unsigned char *fb_firmware_edid(struct fb_info *info);
+#else
+static inline const unsigned char *fb_firmware_edid(struct fb_info *info)
+{
+	return NULL;
+}
+#endif
+
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 43
 #define DMT_SIZE 0x50
-- 
2.41.0

