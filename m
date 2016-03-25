From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/4] exit_thread: accept a task parameter to be exited
Date: Fri, 25 Mar 2016 19:32:11 +1100 (AEDT)
Message-ID: <3qWc3w0GCtz9sdm@ozlabs.org>
References: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1458824294-29733-1-git-send-email-jslaby@suse.cz>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: <linux-hexagon.vger.kernel.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jiri Slaby <jslaby@suse.cz>, Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6, x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Helge Deller <deller@gmx>

On Thu, 2016-24-03 at 12:58:13 UTC, Jiri Slaby wrote:
> We need to call exit_thread from copy_process in a fail path.  So make
> it accept task_struct as a parameter.

If I'm counting right 22 of those are empty functions, so would it be a good
clean up to make it optional first?

cheers

