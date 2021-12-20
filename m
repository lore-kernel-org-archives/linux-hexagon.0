From: Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] hexagon: use strscpy to copy strings
Date: Mon, 20 Dec 2021 16:50:13 +0800
Message-ID: <20211220085013.959126-1-wangborong@cdjrlc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@codeaurora.org
Cc: wangborong@cdjrlc.com, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/hexagon/kernel/setup.c | 6 +++---
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
-- 
2.34.1

