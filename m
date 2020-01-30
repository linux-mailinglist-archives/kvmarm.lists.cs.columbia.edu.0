Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4714DFB0
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jan 2020 18:13:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 409A34A968;
	Thu, 30 Jan 2020 12:13:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id knEpHxvMbhvv; Thu, 30 Jan 2020 12:13:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A4874A7FD;
	Thu, 30 Jan 2020 12:13:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D813F4A576
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 12:13:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E4qDAg+yuhCi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jan 2020 12:13:33 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 056684A4F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 12:13:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580404412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4XSFE0E4Gksgq4colGF+ekKd22PBCuH+3lUMYjeKtA=;
 b=BM5WMasLx2xUJ/CyGjLMYLh0Ju4ae+H8xlrteV8xzdtpvqcQWyD/uXM5I6cPpVSEy87IFx
 4uWOhZtll2Vr6mKEpKacQX2mKbRqQiTbF2V2+D8SFpt4MJV4tadUE1vUz7Pq5rhbECfKqw
 bZgiT8ihk90SlkCG97kIafwXvIE2XC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-gtgkqmo3OPewGvLDDoy-Ng-1; Thu, 30 Jan 2020 12:13:30 -0500
Received: by mail-wm1-f70.google.com with SMTP id o24so1681637wmh.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 09:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H4XSFE0E4Gksgq4colGF+ekKd22PBCuH+3lUMYjeKtA=;
 b=IGM1cpy9EHEj3t6WOcmd6R46XLKVFVs3mLJLWlbXws9cay8wlq5sQafIP0ee1t8B3g
 kEMKsJ59ajswdgZgzqMYktLPehbUTJLzw43YActoMLc+oIGBxFFfIpJBtpVrp7ttaahd
 SV7c/xvMVkVdMaj1OkwQWh8t8oAb66t4t8Sf5b9lYEVebSycgGrFF1vrOUJbd44H0NY/
 MjG/iOWyJ4RsekJROXioBugpJADbXvsbY5ATPY8OiaK+bRKL/ar7HGdO/rJ3QRgT897V
 vlwyYJvWrfz+3mW8o0SjIbrBmoAZYJ0qIoJvQV+sFqt0nAskFojAFQEHgF2iO+8rnbgH
 IDJg==
X-Gm-Message-State: APjAAAUrnMHZRaCIGrJWG77/AuikBcU1qk1gv7CQiYJrfajQHDpPsiBl
 fhcQXmKpwmXohawdaUlof971005cnLQCq4xLgHx5fRHYeiw/y4CBpmfuH2AfCVVyBJPC1846x27
 wUBKxNfi2gqGYVztbMjjLPESx
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7085734wrc.175.1580404409500; 
 Thu, 30 Jan 2020 09:13:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqymVD4j3W000trrAp+yiZYezamOlUuLI2vEHpmo9N7lQFe0NfMAmfVgtniQBd5Sv2KEKg1xxw==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7085702wrc.175.1580404409282; 
 Thu, 30 Jan 2020 09:13:29 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id i2sm7353450wmb.28.2020.01.30.09.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 09:13:28 -0800 (PST)
Subject: Re: [GIT PULL 00/23] KVM/arm updates for 5.6
To: Marc Zyngier <maz@kernel.org>
References: <20200130132558.10201-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b69fd046-1076-c197-7147-bd65f40ea9df@redhat.com>
Date: Thu, 30 Jan 2020 18:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200130132558.10201-1-maz@kernel.org>
Content-Language: en-US
X-MC-Unique: gtgkqmo3OPewGvLDDoy-Ng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Gavin Shan <gshan@redhat.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 YueHaibing <yuehaibing@huawei.com>, Steven Price <steven.price@arm.com>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Andrew Murray <andrew.murray@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 30/01/20 14:25, Marc Zyngier wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-5.6

Pulled, thanks!

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
