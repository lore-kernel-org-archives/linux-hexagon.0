From: Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date: Tue, 30 May 2023 16:26:08 +0000
Message-ID: <20230530162608.984333-1-azeemshaikh38@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463973; x=1688055973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bINww4BS9Q6hxqerWqXoOb0apgrSo5QFqqzYaEsD6HE=;
        b=MjX3/0w6ekjWWGcLGn9tr1TaBi4CybNxXDzzXBFtWRYXgboucEwWrJZJorQSHNBFZR
         8xY+IPe69+dq1vkIKsmw8QoLy+bR0IDcFCLQRp1qdCXmjrHZO+T4iiW1yTXac52YZPZD
         i8YPRtU9SP3ngHxSCMDT8HOe+TOw2bkcLqC4EL2HQpmYonYqZljzroaO6RH/Q4Y6BdFN
         dPI1wWouIeFmezuItohGf1wF0UYddRct9iRw0s/q1PO5rRNW9yCv2lfeVCb/jNRrEpDn
         ABjbjE2EGvyE2dhtxrV6ca3hWrivplnL2db1hoczt+wvlZPUnJcBo7N85dSt9iC007tt
         FdKA==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hardening@vger.kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/hexagon/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..621674e86232 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -66,9 +66,9 @@ void __init setup_arch(char **cmdline_p)
 		on_simulator = 0;
 
 	if (p[0] != '\0')
-		strlcpy(boot_command_line, p, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, p, COMMAND_LINE_SIZE);
 	else
-		strlcpy(boot_command_line, default_command_line,
+		strscpy(boot_command_line, default_command_line,
 			COMMAND_LINE_SIZE);
 
 	/*
@@ -76,7 +76,7 @@ void __init setup_arch(char **cmdline_p)
 	 * are both picked up by the init code. If no reason to
 	 * make them different, pass the same pointer back.
 	 */
-	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();

