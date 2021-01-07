Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFE2EE996
	for <lists+kvmarm@lfdr.de>; Fri,  8 Jan 2021 00:09:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 862254B3B1;
	Thu,  7 Jan 2021 18:09:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id grgth3SqbvrL; Thu,  7 Jan 2021 18:09:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55E924B36A;
	Thu,  7 Jan 2021 18:09:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 070FB4B310
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Jan 2021 18:09:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zk9y2uWn8zla for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Jan 2021 18:09:34 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEADA4B1F4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Jan 2021 18:09:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610060974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jS5ydj15RUDwI0TqVNH2NZGdEGOPrdAAn5n/Kh60D+E=;
 b=GEutk18zD8tNXfaTMIpIQjNAkk/rA1wjcq9vFV80OajPWFTOiEWOhH3tQcOovQorU/s3D8
 L32UVUVumjBS0+T7GLU3CIHivK/u6lR+8bIKN7WwbYcwEzRTEBwvaHRx0OAF+6uBMEJKMd
 bk+SE7JhVt6z9foSMmUUfM7AcsdtswQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-sPJ9M3YBMMm9aA-Py5BYBQ-1; Thu, 07 Jan 2021 18:09:32 -0500
X-MC-Unique: sPJ9M3YBMMm9aA-Py5BYBQ-1
Received: by mail-wr1-f71.google.com with SMTP id i4so3267796wrm.21
 for <kvmarm@lists.cs.columbia.edu>; Thu, 07 Jan 2021 15:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jS5ydj15RUDwI0TqVNH2NZGdEGOPrdAAn5n/Kh60D+E=;
 b=SE0oSqTsvq0SKbFme5OhimCOaZsR3qrl7Wlle3EeMNwNd7xNWVy3ukO9EyA71aZA1N
 U/4Hz0w1knQesW1kdfaXS7I0lfNDsxeITH+p5/Kys8LqKTGzlLLlDCH9oPFThmiRHklO
 wVUO+mqE5R3tDKjMw+EJOUXIzlsy4xQ69iNCXoVkubO+QtE7TmH4xszfV9l54w3IAwUU
 LQiZdgOaDy5RGZAbsIDBGrnqknNZ6B02Kbjn/ucM4X+5WLKPwWG2qLEaMfJufauZiJDy
 UnYmwify8al4hetfd4I9zNzexoE9IU/wN9UIj5EoQFhdmEtM50++iXvjFsJhxYZztOJ6
 Yi3Q==
X-Gm-Message-State: AOAM530sXj/vnolVFzMMV1Shf+CEQMhnsTjP7ug3pBAbEAcsWhslDUKD
 uurx7flr/lnVdHM7wG3p8VxSvY6E6UIjcGK+N6wO2qj4EkifnUQFIh8X0bVEcoXMW+s6HDshJmU
 T/Go/2vwJ6mzGW7dqt4N1/eBY
X-Received: by 2002:a1c:741a:: with SMTP id p26mr632812wmc.47.1610060971572;
 Thu, 07 Jan 2021 15:09:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1vCriFaS/d2WItmJer48+lx8LkEnY4JNrYOgKqDnQhiqtppnmfyDenoJYOL9XXWlswKroWw==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr632789wmc.47.1610060971391;
 Thu, 07 Jan 2021 15:09:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id h15sm10070451wru.4.2021.01.07.15.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 15:09:30 -0800 (PST)
Subject: Re: [GIT PULL] KVM/arm64 fixes for 5.11, take #1
To: Marc Zyngier <maz@kernel.org>
References: <20210107112101.2297944-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35b38baf-bd75-9054-76f8-15e642e05f55@redhat.com>
Date: Fri, 8 Jan 2021 00:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210107112101.2297944-1-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel-team@android.com, kvm@vger.kernel.org, Qian Cai <qcai@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org,
 Nathan Chancellor <natechancellor@gmail.com>, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 07/01/21 12:20, Marc Zyngier wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.11-1

Looks like there are issues with the upstream changes brought in by this 
pull request.  Unless my bisection is quick tomorrow it may not make it 
into 5.11-rc3.  In any case, it's in my hands.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
