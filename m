From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 00/29] bitops: add parity functions
Date: Sun, 17 Apr 2016 05:38:57 -0700
Message-ID: <20160417123857.GD33215@dtor-ws>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rF8tBR6FeVKmNAFmTqMzkb6ZmHXyqas7YHtcuM09CVM=;
        b=V7pNzT7xeuViB4xZOm2JrSU0tSeVXJntYg5RhBPcD7zHw7IoZ2OYcfO9sEsjXwLn22
         ING2eDG0+QXUAP+EMYRTujmlTpaCXBVezK2Ih+BXbVGMwHotL5iNbtmLCs7iWmKQxyfz
         8KCByXPfPT47Y7bP+5iNuDnnbdzZh2UKiJAm7pMeHO5Blrwv3hVadksTe9yoxTWfttJg
         JThYcaJjltSG4HlK1ZC4zAGjTJfVLabSBV1ErVe53vST21wOTDceV7JGTI4e06Nkv3y4
         MRr9tamYLjIVkUz3De/VMUQbBeLtfKh3gKxt5jYcmkYtkca9WYREBjdKTke6JIATNKUx
         o8+Q==
Content-Disposition: inline
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zengzhaoxiu@163.com
Cc: linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Anton Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Borislav Petkov <bp@suse.de>, Bruce Allan <bruce.w.allan@intel.com>, Christophe Leroy <christophe.leroy@c-s.fr>, David Herrmann <dh.herrmann@gmail.com>, "David S. Miller" <davem@davemloft.net>, Denys Vlasenko <dvlasenk@redhat.com>, Duson Lin <dusonlin@emc.com.tw>, Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>, Hartmut Knaack <knaack.h@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik

On Thu, Apr 14, 2016 at 10:36:41AM +0800, zengzhaoxiu@163.com wrote:
>  drivers/input/joystick/grip_mp.c             |  16 +--
>  drivers/input/joystick/sidewinder.c          |  24 +----
>  drivers/input/mouse/elantech.c               |  10 +-
>  drivers/input/mouse/elantech.h               |   1 -
>  drivers/input/serio/ams_delta_serio.c        |   8 +-
>  drivers/input/serio/pcips2.c                 |   2 +-
>  drivers/input/serio/sa1111ps2.c              |   2 +-

For input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

